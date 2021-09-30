#!/bin/sh
echo ""
echo "Welcome to WizBot. Downloading the latest installer..."
root=$(pwd)

rm "$root/w-menu.sh" 1>/dev/null 2>&1
wget -N https://raw.githubusercontent.com/Wizkiller96/wizbot-bash-installer/master/w-menu.sh

bash w-menu.sh
cd "$root"
rm "$root/w-menu.sh"
exit 0