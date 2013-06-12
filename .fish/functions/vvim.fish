#
# Start vim without plugins (vanilla vim)
# => useful for when sublime text interferes with vim plugins
#

function vvim --description "Start vim without plugins"
	command vim --noplugin $argv
end

