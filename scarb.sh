#!/usr/bin/env bash

## Extract the version of scarb from Cargo.toml used by dojo
scarb_dependence=$(grep 'scarb =' Cargo.toml)
dojo_scarb_version=$(echo $scarb_dependence | grep -oP 'tag = "v\K[^"]+')

## Extract the version of scarb installed in local machine
local_scarb_version=$(echo $(scarb --version) | grep -oP '\b\d+\.\d+\.\d+\b' | head -n 1)

## Check if the local scarb version is older than the dojo scarb version
if [ "$local_scarb_version" \< "$dojo_scarb_version" ]; then
    read -p "Do you want to install the latest scarb version locally? (y/n): " install_choice
    if [ "$install_choice" = "y" ]; then
        curl --proto '=https' --tlsv1.2 -sSf https://docs.swmansion.com/scarb/install.sh | sh 
    else
        echo "Skipping scarb installation."
    fi
else 
    echo $(scarb --version)
fi
