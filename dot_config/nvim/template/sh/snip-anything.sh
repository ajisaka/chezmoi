
command -v anything > /dev/null || function anything () {
  local items
  items="$(cat)"
  exec </dev/tty
  IFS=$'\n'
  select it in $items
  do
    [ -z "$it" ] && exit 1
    echo "$it"
    break
  done
}


