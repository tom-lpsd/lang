#!/usr/bin/env ruby

require 'time'
require 'net/https'
require 'rexml/document'

require 'openssl'
require 'digest/sha1'
require 'base64'
require 'uri'

module S3

  module Authorized

    @@public_key = '1S637VAGNG22EXKCB902'
    @@private_key = 'ZnQLc4ra+Qs1hFMNBxYIkguS1JEAkjzFsQmTCcEa'

    if @@public_key.empty? or @@private_key.empty?
      raise "You need to set your S3 key"
    end

    HOST = "s3.amazonaws.com"

    INTERESTING_HEADERS = ['content-type', 'content-md5', 'date']

    AMAZON_HEADER_PREFIX = 'x-amz-'

    METHODS = {
      :get => Net::HTTP::Get,
      :put => Net::HTTP::Put,
      :post => Net::HTTP::Post,
      :delete => Net::HTTP::Delete,
    }

    def request(path, headers_and_options={}, *args, &block)
      method = headers_and_options.delete(:method) || :get
      req = METHODS[method].new(path)
      req.body = headers_and_options.delete(:body)
      headers_and_options.each { |h, v| req[h] = v }
      req['Date'] ||= Time.now.httpdate
      req['Content-Type'] ||= ''
      signed = signature("http://" + HOST + path, method, req)
      req['Authorization'] = "AWS #{@@public_key}:#{signed}"
      response = ''
      https = Net::HTTP.new(HOST, 80)
      https.start { |http|
        response = http.request(req)
      }
      response
    end

    def signature(uri, method=:get, headers={}, expires=nil)
      if uri.respond_to? :path
        path = uri.path
      else
        uri = URI.parse(uri)
        path = uri.path + (uri.query ? "?" + query : "")
      end
      signed_string = sign(canonical_string(method, path, headers, expires))
    end

    def canonical_string(method, path, headers, expires=nil)
      sign_headers = {}
      INTERESTING_HEADERS.each {|header| sign_headers[header] = ''}

      headers.each do |header, value|
        if header.respond_to? :to_str
          header = header.downcase
          if INTERESTING_HEADERS.member?(header) ||
              header.index(AMAZON_HEADER_PREFIX) == 0
            sign_headers[header] = value.to_s.strip
          end
        end
      end

      sign_headers['date'] = '' if sign_headers.has_key? 'x-amz-date'
      sign_headers['date'] = expires.to_s if expires

      canonical = method.to_s.upcase + "\n"

      sign_headers.sort_by { |h| h[0] }.each do |header, value|
        canonical << header << ":" if header.index(AMAZON_HEADER_PREFIX)==0
        canonical << value << "\n"
      end

      canonical << path.gsub(/\?.*$/, '')

      for param in ['acl', 'torrent', 'logging']
        if path =~ Regexp.new("[&?]#{param}($|&|=)")
          canonical << "?" << param
          break
        end
      end
      return canonical
    end

    def sign(str)
      digest_generator = OpenSSL::Digest::Digest.new('sha1')
      digest = OpenSSL::HMAC.digest(digest_generator, @@private_key, str)
      return Base64.encode64(digest).strip
    end

  end

  class BucketList
    include Authorized
    def get
      buckets = []
      doc = REXML::Document.new(request('/').body)
      REXML::XPath.each(doc, "//Bucket/Name") do |e|
        buckets << Bucket.new(e.text) if e.text
      end
      return buckets
    end
  end

  class Bucket
    include Authorized
    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def path
      '/' + URI.escape(name)
    end

    def get(options={})
      uri = path()
      suffix = '?'

      options.each do |param, value|
        if [:Prefix, :Marker, :Delimiter, :MaxKeys].member? :param
          path << suffix << param.to_s << '=' << URI.escape(value)
          suffix = '&'
        end
      end

      res = request(path)
      doc = REXML::Document.new(res.body)
      there_are_more = REXML::XPath.first(doc, "//IsTruncated").text == "true"

      objects = []

      REXML::XPath.each(doc, "//Contents/Key") do |e|
        objects << Object.new(self, e.text) if e.text
      end
      return objects, there_are_more
    end

    def put(acl_policy=nil)
      args = {:method => :put}
      args["x-amz-acl"] = acl_policy if acl_policy
      res = request(path, args)
      raise "put #{path} failed" if res.code != 200
      return self
    end

    def delete
      res = request(path, :method => :delete)
      raise "delete #{path} failed" if res.code != 204
      return self
    end

  end

  class Object
    include Authorized

    attr_reader :bucket
    attr_accessor :name
    attr_writer :metadata, :value

    def initialize(bucket, name, value=nil, metadata=nil)
      @bucket, @name, @value, @metadata = bucket, name, value, metadata
    end

    def path
      @bucket.path + '/' + URI.escape(name)
    end

    def metadata
    end

    def value
      unless @value
        res = request(path)
        @value = res.body
      end
      return @value
    end

    def put(acl_policy=nil)
      args = @metadata ? @metadata.clone : {}
      args[:method] = :put
      args["x-amz-acl"] = acl_policy if acl_policy
      if @value
        args["Content-Length"] = @value.size.to_s
        args[:body] = @value
      end
      request(path, args)
      return self
    end

  end
end
