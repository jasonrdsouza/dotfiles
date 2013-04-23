# Tab completion
require 'irb/completion'

# Pretty printing
require 'pp'

# Fancy prompt
IRB.conf[:PROMPT][:CUSTOM] = {
  :PROMPT_I => ">> ",
  :PROMPT_S => "%l>> ",
  :PROMPT_C => ".. ",
  :PROMPT_N => ".. ",
  :RETURN => "=> %s\n"
}
IRB.conf[:PROMPT_MODE] = :CUSTOM
IRB.conf[:AUTO_INDENT] = true

# save history between irb sessions
require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

# Enable colorized output
require 'wirble'
Wirble.init
Wirble.colorize

require 'bond'; Bond.start

# Handy shortcuts
def ls
  %x{ls}.split("\n")
end

def rl(file_name = nil)
  if file_name.nil?
    if !@recent.nil?
      rl(@recent)
    else
      puts "No recent file to reload"
    end
  else
    file_name += '.rb' unless file_name =~ /\.rb/
    @recent = file_name
    load "#{file_name}"
  end
end

def ex(cmd)
  puts cmd
  puts `#{cmd}`
end

# Inform us of the version, and that IRB is ready
puts "Ruby #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL} (Gemset: #{`rvm gemset name`.chomp}) #{RUBY_PLATFORM}"

