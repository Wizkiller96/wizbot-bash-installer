#!/bin/sh
echo "Running WizBot"
root=$(pwd)

if hash dotnet 2>/dev/null
then
	echo "Dotnet installed."
else
	echo "Dotnet is not installed. Please install dotnet."
	exit 1
fi

cd "$root/wizbot/output"
echo "Running WizBot. Please wait."
dotnet WizBot.dll
echo "Done"

cd "$root"
rm "$root/w-run.sh"
exit 0
