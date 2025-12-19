#!/bin/bash

if [[ $1 == "--help" || $1 == "-h" ]]; then
  cat <<EOF
Usage:
  Installs all configurations in ./config
    ./install.sh

  Doesn't ask to install configurations if already present:
    ./install.sh -f
    ./install.sh --force

  Displays this:
    ./install.sh -h
    ./install.sh --help
EOF
  exit 0
fi

seperator="------------------------"

for config in config/*; do
  if [ -d "$config" ]; then
    echo "$seperator"

    base=$(basename $config)
    install_path="$HOME/.config/$base"

    if [[ -d "$install_path" && $1 != "--force"  || $1 != "-f" ]]; then
      echo "$base config already installed!"
      read -e -p "Replace it? (y/n): " choice
      [[ "$choice" == [Yy]* ]] || continue
    fi

    [ -d $install_path ] && rm -rf "$install_path"
    cp -f -r "$config" "$install_path"
    echo "Installed $base $install_path"

  fi
done

echo "$seperator" 
echo "Finished!"
