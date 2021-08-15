#!/bin/sh
root=$(pwd)

# todo data handling
# todo if nadekobot exists
mv nadekobot nadekobot_old
git clone https://gitlab.com/kwoth/nadekobot -b v3 --depth 1
cd nadekobot

export DOTNET_CLI_TELEMETRY_OPTOUT=1
dotnet build src/NadekoBot/NadekoBot.csproj -c Release -o output/

# todo if old exists
mv -f nadekobot_old/output/data/NadekoBot.db nadekobot/output/data/NadekoBot.db
cp -RT nadekobot_old/data/ nadekobot/data/ 1>/dev/null 2>&1

cd "$root"
rm "$root/n-install.sh"
exit 0