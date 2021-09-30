#!/bin/sh
root=$(pwd)

# Legend:
# (A) - Database related operations
# (B) - Aliases related operations
# (C) - Strings related operations

# remove old backup
rm -rf wizbot_old 1>/dev/null 2>&1

# make a new backup
mv -fT wizbot wizbot_old 1>/dev/null 2>&1

# clone new version
git clone -b v3 --recursive --depth 1 https://github.com/Wizkiller96/WizBot
cd wizbot

# build
export DOTNET_CLI_TELEMETRY_OPTOUT=1
dotnet build src/WizBot/WizBot.csproj -c Release -o output/

# go back
cd "$root"

# move creds from old to new
mv -f wizbot_old/output/creds.yml wizbot/output/creds.yml 1>/dev/null 2>&1
# also copy credentials.json for migration purposes
mv -f wizbot_old/output/credentials.json wizbot/output/credentials.json 1>/dev/null 2>&1

# on update, strings will be new version, user will have to manually re-add his strings after each update
# as updates may cause big number of strings to become obsolete, changed, etc
# however, old user's strings will be backed up to strings_old

# (C) backup new strings to reverse rewrite
rm -rf wizbot/output/data/strings_new 1>/dev/null 2>&1
mv -fT wizbot/output/data/strings wizbot/output/data/strings_new 1>/dev/null 2>&1
# (C) delete old strings backup
rm -rf wizbot_old/output/data/strings_old 1>/dev/null 2>&1
rm -rf wizbot_old/output/data/strings_new 1>/dev/null 2>&1

# (B) backup new aliases to reverse rewrite
mv -f wizbot/output/data/aliases.yml wizbot/output/data/aliases_new.yml 1>/dev/null 2>&1

# (A) move old database
mv -f wizbot_old/output/data/WizBot.db wizbot/output/data/WizBot.db 1>/dev/null 2>&1

# move old data folder contents (and overwrite)
cp -RT wizbot_old/output/data/ wizbot/output/data 1>/dev/null 2>&1

# (B) backup old aliases
mv -f wizbot/output/data/aliases.yml wizbot/output/data/aliases_old.yml 1>/dev/null 2>&1
# (B) restore new aliases
mv -f wizbot/output/data/aliases_new.yml wizbot/output/data/aliases.yml 1>/dev/null 2>&1

# (C) backup old strings
mv -f wizbot/output/data/strings wizbot/output/data/strings_old 1>/dev/null 2>&1
# (C) restore new strings
mv -f wizbot/output/data/strings_new wizbot/output/data/strings 1>/dev/null 2>&1

cd "$root"
rm "$root/w-download.sh"
exit 0