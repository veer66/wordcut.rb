# wordcut.rb
ASEAN word tokenizer written in Ruby.

## Example
### Thai

     # coding: utf-8
     require 'wordcut/dict'
     require 'wordcut/tokenizer'
     require 'pp'

     tha_dict = Wordcut::BasicDict.from_bundle("tha", "tdict-std.txt")
     tokenizer = Wordcut::BasicTokenizer.new(tha_dict)
     PP.pp tokenizer.tokenize('กากากา')
