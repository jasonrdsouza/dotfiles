Pry.config.editor = 'vim'

# Toys methods
# See https://gist.github.com/807492
class Array
  def self.toy(n=10, &block)
    block_given? ? Array.new(n,&block) : Array.new(n) {|i| i+1}
  end
end

class Hash
  def self.toy(n=10)
    Hash[Array.toy(n).zip(Array.toy(n){|c| (96+(c+1)).chr})]
  end
end

# Print ruby version and gemset info
puts "Ruby #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL} (Gemset: #{`rvm gemset name`.chomp}) #{RUBY_PLATFORM}"

