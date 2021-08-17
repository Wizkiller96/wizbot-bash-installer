#!/bin/sh

echo "Welcome to NadekoBot installer"
echo ""

root=$(pwd)
choice=9
	
base_url="https://gitlab.com/Kwoth/nadeko-bash-installer/-/raw/master"

script_menu="n-menu.sh"
script_prereq="n-prereq.sh"
script_install="n-install.sh"
script_run="n-run.sh"
script_arn="n-arn.sh"

# MIGRATION START
if [ -d "NadekoBot" ]
then 
	if [ -d "nadekobot" ]
	then
		echo "Both NadekoBot and nadekobot folders exist, migration from 2.x to v3 can't proceed."
		cd "$root"
		exit 0
	fi

	echo "Migrating 2.x to 1.9"
	mv NadekoBot nadekobot
	base_migration_folder="nadekobot/src/NadekoBot/bin/Release/netcoreapp2.1"
	mkdir nadekobot/output
	cp -rf "$base_migration_folder/data" nadekobot/output/data
	cp nadekobot/src/NadekoBot/credentials.json nadekobot/output

	echo "Old data migration has been set up. However, you must run options 1, 2 and 3 (in that order) for the migration to properly take effect."
	sleep 1
fi
# MIGRATION END

while [ $choice -eq 9 ]; do
	
	echo "1. Install Prerequisites"
	echo "2. Install NadekoBot"
    echo "3. Run NadekoBot"
	echo "4. Run NadekoBot with Auto Restart in this session"
	echo "5. Exit"
	echo -n "Type in the number of an option and press ENTER"
	echo ""
	read choice	

	if [[ $choice -eq 1 ]] ; then
		echo ""
		echo "Downloading the prerequisites installer script"
		wget -N "$base_url/$script_prereq" && bash "$root/$script_prereq"
		echo ""
		choice=9
	elif [[ $choice -eq 2 ]] ; then
		echo ""
		echo "Downloading the NadekoBot installer script"
		wget -N "$base_url/$script_install" && bash "$root/$script_install"
		echo ""
		sleep 2s
		choice=9
	elif [[ $choice -eq 3 ]] ; then
		echo ""
		echo "Downloading the NadekoBot run script"
		wget -N "$base_url/$script_run" && bash "$root/$script_run"
		echo ""
		sleep 2s
		bash "$root/linuxAIO.sh"
	elif [[ $choice -eq 4 ]] ; then
		echo ""
		echo "Downloading the NadekoBot run and auto restart script"
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