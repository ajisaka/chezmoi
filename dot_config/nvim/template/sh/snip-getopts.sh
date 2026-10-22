# 後ろに `:` があるオプションは値を取る
# 先頭に `:` があると、自動エラー検知が省略される
while getopts 'd:fhc' OPTION
do
  case "$OPTION" in
    d)
      VALUE_D=$OPTARG
      ;;
    f)
      OPT_DO_FOCUS=1
      ;;
    c)
      clean
      exit
      ;;
    h)
      usage
      exit
    ;;
    *)
      usage
      exit 1
  esac
done
shift $((OPTIND - 1))

echo "d = $VALUE_D, do_docus = $OPT_DO_FOCUS"
