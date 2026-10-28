# function caching () {
command -v caching > /dev/null || function caching () {
  "$@"
}

