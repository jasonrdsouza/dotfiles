#
# Monitor the copy/ paste buffer
#

function clipmon --description "monitor copy/paste buffer"
  set last_value ''

  while true
    set value (pbpaste)

    if test "$last_value" != "$value"
      echo "$value"
      set last_value "$value"
    end

    sleep 0.1
  end
end

