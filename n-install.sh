# todo data handling
git clone https://gitlab.com/kwoth/nadekobot -b v3 --depth 1
cd nadekobot

export DOTNET_CLI_TELEMETRY_OPTOUT=1
dotnet build src/NadekoBot/NadekoBot.csproj -c Release -o output/

cd "$root"
rm "$root/n-install.sh"
exit 0