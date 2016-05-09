$LOAD_PATH << File.expand_path("../wordcut", __FILE__)

Gem::Specification.new do |s|
  s.name = 'wordcut'
  s.version = '0.0.5'
  s.authors = ['Vee Satayamas']
  s.email = ['v.satayamas@gmail.com']
  s.licenses = ['LGPL-3.0']
  s.description = "Word segmentation tools for ASEAN languages written in Ruby"
  s.homepage = "https://github.com/veer66/wordcut.rb"
  s.require_paths = ["wordcut"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0")
  s.summary = "Word segmetation tools for ASEAN languages"
  s.files = Dir.glob("wordcut/*") + %w(README.md LICENSE) + Dir.glob("data/**/*")
  s.require_paths = ['.']
end
