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


# Useful locations
#
trtop = ENV['TRTOP']
whtop = ENV['WHTOP']
commerce_scripts = File.join(trtop, 'scripts', 'commerce')
hadutils_path = File.join(trtop, 'ruby', 'warehouse', 'hadutils.rb')
cutils_path = File.join(trtop, 'ruby', 'commerce', 'cutils.rb')
whois_path = File.join(commerce_scripts, 'fraud_filtering', 'whois.rb')


# Print ruby version and gemset info
puts "Ruby #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL} (Gemset: #{`rvm gemset name`.chomp}) #{RUBY_PLATFORM}"

