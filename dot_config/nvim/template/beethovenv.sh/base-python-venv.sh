wd="$(dirname "$0")"
[ -d "${wd}/.venv" ] || virtualenv "${wd}/.venv" --python=/usr/bin/python3.9
[ -e "${wd}/src/requirements.txt" ] && pip install -r "${wd}/src/requirements.txt"
[ -e "src/requirements.txt" ] && pip install -r "src/requirements.txt"
