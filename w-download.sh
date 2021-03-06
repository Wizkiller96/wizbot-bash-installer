#!/bin/sh

root=$(pwd)

# remove old backup
rm -rf wizbot_old 1>/dev/null 2>&1

# make a new backup
mv -fT wizbot wizbot_old 1>/dev/null 2>&1

# clone new version
git clone -b v4 --recursive --depth 1 https://github.com/Wizkiller96/wizbot

wget -q -N https://raw.githubusercontent.com/Wizkiller96/wizbot-bash-installer/v4/rebuild.sh
bash rebuild.sh

cd "$root"
rm "$root/w-download.sh"
exit 0
