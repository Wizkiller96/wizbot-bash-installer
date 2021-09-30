#!/bin/sh

echo "Welcome to WizBot installer"
echo ""

root=$(pwd)
choice=9
	
base_url="https://github.com/Wizkiller96/wizbot-bash-installer/-/raw/master"

script_menu="w-menu.sh"
script_prereq="w-prereq.sh"
script_install="w-download.sh"
script_run="w-run.sh"
script_arn="w-arn.sh"

# MIGRATION START
if [ -d "WizBot" ]
then 
	if [ -d "wizbot" ]
	then
		echo "Both WizBot and wizbot folders exist, migration from 2.x to v3 can't proceed."
		cd "$root"
		exit 0
	fi

	echo "Migrating 2.x to v3"
	mv WizBot wizbot
	base_migration_folder="wizbot/src/WizBot/bin/Release/netcoreapp2.1"
	mkdir -p wizbot/output/data/
	# db is in bin/Release
	cp "$base_migration_folder/data/WizBot.db" wizbot/output/data/
	# data is in WizBot/data
	cp -rf "wizbot/src/WizBot/data" wizbot/output/data
	cp wizbot/src/WizBot/credentials.json wizbot/output

	echo "Old data migration has been set up. However, you must run options 1, 2 and 3 (in that order) for the migration to properly take effect."
	sleep 1
fi
# MIGRATION END

while [ $choice -eq 9 ]; do
	
	echo "1. Install Prerequisites"
	echo "2. Download WizBot"
    echo "3. Run WizBot"
	echo "4. Run WizBot with Auto Restart in this session"
	echo "5. Exit"
	echo -n "Type in the number of an option and press ENTER"
	echo ""
	read choice	

	if [[ $choice -eq 1 ]] ; then
		echo ""
		echo "Downloading the prerequisites installer script"
		rm "$root/$script_prereq" 1>/dev/null 2>&1
		wget -N "$base_url/$script_prereq" && bash "$root/$script_prereq"
		echo ""
		choice=9
	elif [[ $choice -eq 2 ]] ; then
		echo ""
		echo "Downloading the WizBot installer script"
		rm "$root/$script_install" 1>/dev/null 2>&1
		wget -N "$base_url/$script_install" && bash "$root/$script_install"
		echo ""
		sleep 2s
		choice=9
	elif [[ $choice -eq 3 ]] ; then
		echo ""
		echo "Downloading the WizBot run script"
		rm "$root/$script_run" 1>/dev/null 2>&1
		wget -N "$base_url/$script_run" && bash "$root/$script_run"
		echo ""
		sleep 2s
		bash "$root/linuxAIO.sh"
	elif [[ $choice -eq 4 ]] ; then
		echo ""
		echo "Downloading the WizBot run and auto restart script"
		rm "$root/$script_arn" 1>/dev/null 2>&1
		wget -N "$base_url/$script_arn" && bash "$root/$script_arn"
		echo ""
		sleep 2s
		bash "$root/linuxAIO.sh"
	elif [[ $choice -eq 5 ]] ; then
		echo ""
		echo "Exiting..."
		cd "$root"
		exit 0
	else
		echo "Invalid choice"
		echo ""
		choice=9
	fi
done

cd "$root"
exit 0