from distutils.core import setup, Extension

module1 = Extension('spammodule',
                    sources = ['spammodule.c'])

setup (name = 'Spam',
       version = '1.0',
       description = 'This is a spam package',
       ext_modules = [module1])

