

tempfile="$(mktemp)"

trap clean EXIT
clean()
{
  rm "$tempfile"
}
