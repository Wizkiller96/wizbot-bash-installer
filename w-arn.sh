#!/bin/sh
echo "Running WizBot"
root=$(pwd)

if hash dotnet 2>/dev/null
then
	echo "Dotnet is installed."
else
	echo "Dotnet is not installed. Please install preqrequisites (option 1)."
	exit 1
fi

echo "Running WizBot. Please wait."
while :; do cd "$root/wizbot/output" && dotnet WizBot.dll && youtube-dl -U; sleep 5s; done
echo "Done"

cd "$root"
rm "$root/w-arn.sh"
exit 0
