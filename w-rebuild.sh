#!/bin/sh
root=$(pwd)

# remove old backup
rm -rf wizbot_old 1>/dev/null 2>&1

# make a new backup
cp -rT wizbot wizbot_old 1>/dev/null 2>&1

wget -q -N https://raw.githubusercontent.com/Wizkiller96/wizbot-bash-installer/v4/rebuild.sh
bash rebuild.sh

cd "$root"
rm "$root/w-rebuild.sh"
exit 0