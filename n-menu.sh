#!/bin/sh

echo "Welcome to NadekoBot."
root=$(pwd)
echo ""
choice=9
	echo "1. Install Prerequisites"
	echo "2. Install NadekoBot"
    echo "3. Run NadekoBot"
	echo "4. Run NadekoBot with Auto Restart in this session"
	echo "5. Auto-Install Prerequisites (For Ubuntu, Debian and CentOS)"
	echo "6. Exit"
	echo -n "Choose [1] to Download, [2 or 3] to Run, [6 and 7] for pm2 setup/startup (see README) or [8] to Exit."
read choice

if [ $choice -eq 1 ] ; then

	echo ""
	echo "Downloading NadekoBot, please wait."
	wget -N https://github.com/Kwoth/NadekoBot-BashScript/raw/1.9/nadeko_installer_latest.sh && bash "$root/nadeko_installer_latest.sh"
	echo ""
	bash "$root/linuxAIO.sh"
else
		if [ $choice -eq 2 ] ; then
			echo ""
			echo "Running Nadeko Normally, if you are running this to check Nadeko, use .die command on discord to stop Nadeko."
			wget -N https://github.com/Kwoth/NadekoBot-BashScript/raw/1.9/nadeko_run.sh && bash "$root/nadeko_run.sh"
			echo ""
			echo "Welcome back to NadekoBot."
			sleep 2s
			bash "$root/linuxAIO.sh"
		else
			if [ $choice -eq 3 ] ; then
				echo ""
				echo "Running Nadeko with Auto Restart you will have to close the session to stop the auto restart."
				sleep 5s
				wget -N https://github.com/Kwoth/NadekoBot-BashScript/raw/1.9/NadekoAutoRestartAndUpdate.sh && bash "$root/NadekoAutoRestartAndUpdate.sh"
				echo ""
				echo "That did not work?"
				sleep 2s
				bash "$root/linuxAIO.sh"
			else
				if [ $choice -eq 4 ] ; then
					echo ""
					echo "Getting the Auto-Installer for Debian/Ubuntu"
					wget -N https://github.com/Kwoth/NadekoBot-BashScript/raw/1.9/nadekoautoinstaller.sh && bash "$root/nadekoautoinstaller.sh"
					echo ""
					echo "Welcome back..."
					sleep 2s
					bash "$root/linuxAIO.sh"
				else 
                    if [ $choice -eq 6 ] ; then
						echo ""
						echo "Starting the setup for pm2 with NadekoBot. This only has to be done once."
						wget -N https://github.com/Kwoth/NadekoBot-BashScript/raw/1.9/nadekopm2setup.sh && bash "$root/nadekopm2setup.sh"
						echo ""
						echo "Welcome back..."
						sleep 2s
						bash "$root/linuxAIO.sh"	
						else
							if [ $choice -eq 7 ] ; then
							echo ""
							echo "Getting the pm2 startup options for NadekoBot.."
							wget -N https://github.com/Kwoth/NadekoBot-BashScript/raw/1.9/nadekobotpm2start.sh && bash "$root/nadekobotpm2start.sh"
							echo ""
							sleep 2s
							bash "$root/linuxAIO.sh"
							else
								if [ $choice -eq 8 ] ; then
									echo ""
									echo "Exiting..."
									cd "$root"
									exit 0
								else
									clear
									echo "1. Download NadekoBot"
									echo "2. Run Nadeko (Normally)"
									echo "3. Run Nadeko with Auto Restart in this session"
									echo "4. Auto-Install Prerequisites (For Ubuntu, Debian and CentOS)"
									echo "5. Set up credentials.json (If you have downloaded NadekoBot already)"
									echo "6. Auto-Install pm2 (For pm2 information, see README!)"
									echo "7. Start Nadeko in pm2 (Complete option 6 first!)"
									echo "8. Exit"
									echo -n "Choose [1] to Download, [2 or 3] to Run, [6 and 7] for pm2 setup/startup (see README) or [8] to Exit."
									choice=9
								fi
							fi	
						fi 
					fi
				fi
			fi
		fi
	fi
done

cd "$root"
exit 0
