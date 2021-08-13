# Install dotnet
#!/bin/bash -e
root=$(pwd)
echo ""

function detect_OS_ARCH_VER_BITS {
	ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')
	if [ -f /etc/lsb-release ]; then
	    . /etc/lsb-release
	    OS=$DISTRIB_ID
	    VER=$DISTRIB_RELEASE
	elif [ -f /etc/debian_version ]; then
	    OS=Debian  # XXX or Ubuntu??
	    VER=$(cat /etc/debian_version)
	    SVER=$( cat /etc/debian_version | grep -oP "[0-9]+" | head -1 )
	elif [ -f /etc/centos-release ]; then
		OS=CentOS
		VER=$( cat /etc/centos-release | grep -oP "[0-9]+" | head -1 )
	else
	    OS=$(uname -s)
	    VER=$(uname -r)
	fi
	case $(uname -m) in
	x86_64)
	    BITS=64
	    ;;
	i*86)
	    BITS=32
	    ;;
	armv*)
	    BITS=32
	    ;;
	*)
	    BITS=?
	    ;;
	esac
	case $(uname -m) in
	x86_64)
	    ARCH=x64  # or AMD64 or Intel64 or whatever
	    ;;
	i*86)
	    ARCH=x86  # or IA32 or Intel32 or whatever
	    ;;
	*)
	    # leave ARCH as-is
	    ;;
	esac
}

declare OS ARCH VER BITS

detect_OS_ARCH_VER_BITS

export OS ARCH VER BITS

if [ "$BITS" = 32 ]; then
	echo -e "Your system architecture is $ARCH which is unsupported to run Microsoft .NET Core SDK. \nYour OS: $OS \nOS Version: $VER"
	echo
	printf "\e[1;31mPlease check the NadekoBot self-hosting guide for alternatives.\e[0m\n"
	rm nadekoautoinstaller.sh
	exit 1
fi

if [ "$OS" = "Ubuntu" ]; then
	if [ "$VER" = "12.04" ]; then
		supported=0
	elif [ "$VER" = "14.04" ]; then
		supported=1
	elif [ "$VER" = "16.04" ]; then
		supported=1
	elif [ "$VER" = "16.10" ]; then
		supported=1
	elif [ "$VER" = "17.04" ]; then
		supported=1
	elif [ "$VER" = "17.10" ]; then
		supported=1
	elif [ "$VER" = "18.04" ]; then
		supported=1
	elif [ "$VER" = "18.10" ]; then
		supported=1
		VER=18.04
		echo -e "Using Ubuntu 18.04 Installation scripts.\nIf the installation fails contact NadekoBot support."
		sleep 5
	elif [ "$VER" = "19.04" ]; then
		supported=1
	elif [ "$VER" = "19.10" ]; then
		supported=1
		#VER=19.04
		#echo -e "Using Ubuntu 19.04 Installation scripts.\nIf the installation fails contact NadekoBot support."
		#sleep 5
	elif [ "$VER" = "20.04" ]; then
		supported=1
	elif [ "$VER" = "20.10" ]; then
		supported=1
	else
		supported=0
	fi
fi

if [ "$OS" = "LinuxMint" ]; then
	SVER=$( echo $VER | grep -oP "[0-9]+" | head -1 )
	if [ "$SVER" = "18" ]; then
		supported=1
	elif [ "$SVER" = "17" ]; then
		supported=1
	elif [ "$SVER" = "2" ]; then
		supported=1
	else
		supported=0
	fi
fi

if [ "$supported" = 0 ]; then
	echo -e "Your OS $OS $VER $ARCH looks unsupported to run Microsoft .NET Core. \nExiting..."
	printf "\e[1;31mContact NadekoBot's support on Discord with screenshot.\e[0m\n"
	rm nadekoautoinstaller.sh
	exit 1
fi

if [ "$OS" = "Linux" ]; then
	echo -e "Your OS $OS $VER $ARCH probably can run Microsoft .NET Core. \nContact NadekoBot's support on Discord with screenshot."
	rm nadekoautoinstaller.sh
	exit 1
fi

echo "This installer will download all of the required packages for NadekoBot. It will use about 350MB of space. This might take awhile to download if you do not have a good internet connection.\n"
echo -e "Would you like to continue? \nYour OS: $OS \nOS Version: $VER \nArchitecture: $ARCH"

while true; do
    read -p "[y/n]: " yn
    case $yn in
        [Yy]* ) clear; echo Running NadekoBot Auto-Installer; sleep 2; break;;
        [Nn]* ) echo Quitting...; rm nadekoautoinstaller.sh && exit;;
        * ) echo "Couldn't get that please type [y] for Yes or [n] for No.";;
    esac
done

echo ""

# Install DOTNET

if [ "$OS" = "Ubuntu" ]; then

	# Setup dotnet for ubuntu

	echo "Installing dotnet"
	wget "https://packages.microsoft.com/config/ubuntu/$SVER/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb
	sudo dpkg -i packages-microsoft-prod.deb
	rm packages-microsoft-prod.deb

    sudo apt-get update
	sudo apt-get install dotnet


	# echo "Installing snap"
	# sudo apt-get install snapd

	# echo "Installing dotnet"
	# sudo snap install dotnet-sdk --classic --channel=5.0
	# sudo snap alias dotnet-sdk.dotnet dotnet
	
    echo "Installing Git, Redis and Tmux..."
    sudo apt-get install git tmux redis-server -y

    echo "Installing music prerequisites..."
    sudo add-apt-repository ppa:chris-lea/libsodium -y
    sudo apt-get install libopus0 opus-tools libopus-dev libsodium-dev -y
    echo ""
   sudo apt-get install ffmpeg
    sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
    sudo chmod a+rx /usr/local/bin/youtube-dl
elif [ "$OS" = "Debian" ]; then
	if [ "$SVER" = "8" ]; then
		sudo apt-get update

		echo "Installing snap"
		sudo apt-get install snapd

		echo "Installing dotnet"
		sudo snap install dotnet-sdk --classic --channel=5.0
		sudo snap alias dotnet-sdk.dotnet dotnet
		
		echo "Installing Git, Redis and Tmux..."
		sudo apt-get install git tmux redis-server -y

		echo "Installing music prerequisites..."
		sudo add-apt-repository ppa:chris-lea/libsodium -y
		sudo apt-get install libopus0 opus-tools libopus-dev libsodium-dev -y
		sudo snap install ffmpeg
		echo ""
		sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
		sudo chmod a+rx /usr/local/bin/youtube-dl
	else
		echo -e "Your OS $OS $VER $ARCH probably can run Microsoft .NET Core. \nContact NadekoBot's support on Discord with screenshot."
		rm nadekoautoinstaller.sh
		exit 1
	fi
elif [ "$OS" = "LinuxMint" ]; then
	if [ "$SVER" = "18" ]; then
		echo "Installing Git, Redis and Tmux..."
        sudo apt-get install git tmux redis-server -y

        echo "Installing music prerequisites..."
        sudo add-apt-repository ppa:chris-lea/libsodium -y
        sudo apt-get update
        sudo apt-get install libopus0 opus-tools libopus-dev libsodium-dev snapd -y
        sudo snap install ffmpeg
        sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
        sudo chmod a+rx /usr/local/bin/youtube-dl
    fi
elif [ "$OS" = "CentOS" ]; then
	if [ "$VER" = "7" ]; then
		echo ""

		yum install sudo -y
		sudo yum install libunwind libicu -y
		sudo rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm
		sudo yum -y install http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm epel-release
		sudo yum -y install https://centos7.iuscommunity.org/ius-release.rpm
		sudo yum localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm
		sudo yum install git2u opus opus-devel ffmpeg ffmpeg-devel tmux yum-utils -y
		sudo yum install redis -y
		sudo systemctl start redis
		sudo systemctl enable redis
		wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
		chmod a+rx /usr/local/bin/youtube-dl
	else
		echo -e "Your OS $OS $VER $ARCH probably can run Microsoft .NET Core. \nContact NadekoBot's support on Discord with screenshot."
		rm nadekoautoinstaller.sh
		exit 1
	fi
fi

echo
echo "NadekoBot Prerequisites Installation completed..."
read -n 1 -s -p "Press any key to continue..."
sleep 2

cd "$root"
rm "$root/n-prereq.sh"
exit 0
