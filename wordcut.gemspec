$LOAD_PATH << File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name = 'wordcut'
  s.version = '0.0.1'
  s.authors = ['Vee Satayamas']
  s.email = ['v.satayamas@gmail.com']
  s.description = "ASEAN word tokenizer written in Ruby"
  s.homepage = "https://github.com/veer66/wordcut.rb"
  s.require_paths = ["wordcut"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0")
  s.summary = "A word tokenizer for ASEAN languages written in Ruby"
  s.files = Dir.glob("wordcut/**/*") + %w(LICENSE README.md) + Dir.glob("data/*") + Dir.glob("test/test_*.rb")
  s.licenses = ["LGPL-3.0"]
end
