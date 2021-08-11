#!/bin/sh
echo "Running NadekoBot"
root=$(pwd)

if hash dotnet 2>/dev/null
then
	echo "Dotnet installed."
else
	echo "Dotnet is not installed. Please install dotnet."
	exit 1
fi

cd "$root/NadekoBot/src/NadekoBot"
echo "Running NadekoBot. Please wait."
dotnet run -c Release
echo "Done"

cd "$root"
rm "$root/n-run.sh"
exit 0
