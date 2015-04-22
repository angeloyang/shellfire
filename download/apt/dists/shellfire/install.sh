#!/usr/bin/env sh
set -e
set -u

if [ -t 1 ]; then
	printf '%s\n' 'This script will install the apt repository shellfire' 'It will change your apt keys, create or replace /etc/apt/sources.list.d/00shellfire.sources.list, install apt-transport-https and update apt.' 'Press the [Enter] key to continue.'
	read -r garbage
fi

sudo -p "Password for %p to allow root to update from new sources before installing apt-transport-https: " apt-get --quiet update
sudo -p "Password for %p to allow root to  apt-get install apt-transport-https (missing in Debian default installs)" apt-get install apt-transport-https

temporaryKeyFile="$(mktemp --tmpdir shellfire.key.XXXXXXXXX)"
trap 'rm -rf "$temporaryKeyFile"' EXIT HUP INT QUIT TERM
cat >"$temporaryKeyFile" <<EOF
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1

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
ww==
=2vnB
-----END PGP PUBLIC KEY BLOCK-----
EOF
sudo -p "Password for %p is required to allow root to install repository 'shellfire' public key to apt: " apt-key add "$temporaryKeyFile"

echo 'deb https://shellfire-dev.github.io/shellfire/download/apt shellfire multiverse' | sudo -p "Password for %p is required to allow root to install repository 'shellfire' apt sources list to '/etc/apt/sources.list.d/00shellfire.sources.list': " tee /etc/apt/sources.list.d/00shellfire.list >/dev/null
sudo -p "Password for %p to allow root to update from new sources: " apt-get --quiet update
