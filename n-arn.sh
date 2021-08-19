#!/bin/sh
echo "Running NadekoBot"
root=$(pwd)

if hash dotnet 2>/dev/null
then
	echo "Dotnet is installed."
else
	echo "Dotnet is not installed. Please install preqrequisites (option 1)."
	exit 1
fi

echo "Running NadekoBot. Please wait."
while :; do cd "$root/nadekobot/output" && dotnet NadekoBot.dll && youtube-dl -U; sleep 5s; done
echo "Done"

cd "$root"
rm "$root/n-arn.sh"
exit 0
