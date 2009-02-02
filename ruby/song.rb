#!/usr/local/bin/ruby
class Song
  attr_reader :name, :artist, :duration
  def initialize(name, artist, duration)
    @name = name
    @artist = artist
    @duration = duration
  end
  def to_s
    "Song: #{@name}-#{@artist} (#{@duration})"
  end
end

class KaraokeSong < Song
  attr_writer :lyrics
  def initialize(name, artist, duration, lyrics)
    super(name, artist, duration)
    @lyrics = lyrics
  end
  def to_s
    super + " [#{@lyrics}]"
  end
end

class WordIndex
  def initialize
    @index = Hash.new(nil)
  end
  def index(anObject, *phrases)
    phrases.each do |aPhrase|
      aPhrase.scan /\w[-\w']+/ do |aWord|
        aWord.downcase!
        @index[aWord] = [] if @index[aWord].nil?
        @index[aWord].push(anObject)
      end
    end
  end
  def lookup(aWord)
    @index[aWord.downcase]
  end
end

class SongList
  MaxTime = 5*60
  def initialize
    @songs = Array.new
    @index = WordIndex.new
  end
  def append(aSong)
    @songs.push(aSong)
    @index.index(aSong,aSong.name,aSong.artist)
    self
  end
  def lookup(aWord)
    @index.lookup(aWord)
  end
  def deleteFirst
    @songs.shift
  end
  def deleteLast
    @songs.pop
  end
  def [](key)
    return @songs[key] if key.kind_of?(Integer)
    return @songs.find { |aSong| aSong.name == key }
  end
  def SongList.isTooLong(aSong)
    return aSong.duration > MaxTime
  end
end

class Logger
  private_class_method :new
  @@logger = nil
  def Logger.create
    @@logger = new unless @@logger
    @@logger
  end
end

class VU
  include Comparable
  attr :volume
  def initialize(volume)
    @volume = volume
  end
  def inspect
    '#' * @volume
  end
  # support for ranges
  def <=>(other)
    self.volume <=> other.volume
  end
  def succ
    raise(IndexError, "Volume too big") if @volume >= 9
    VU.new(@volume.succ)
  end
end

# Songオブジェクトのテスト
aSong = Song.new("Bicylops", "Fleck", 260);
bSong = KaraokeSong.new("My Way", "Singatra", 225, "And now, the ...")
bSong.lyrics = "And past, the ..."
puts bSong.to_s
puts SongList.isTooLong(bSong)
puts Logger.create.object_id
puts Logger.create.object_id

# Arrayのテスト
a = [3.141592, "pie", 99]
puts a.class
puts a.length
a[99] = 100
puts a.length
puts a[23]

# SongListのテスト
list = SongList.new
list.
  append(Song.new('title1','artist1',1)).
  append(Song.new('title2','artist2',2)).
  append(Song.new('title3','artist3',3)).
  append(Song.new('title4','artist4',4))

puts list.inspect

# list.deleteFirst
# list.deleteFirst
# list.deleteLast
# list.deleteLast

# puts list.deleteLast

puts list['title3']
puts list['title2']
puts list[9]
