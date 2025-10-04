#!/bin/bash

has_all=true

while read package; do
	if ! command -V $package &> /dev/null; then
		echo "Missing ${package}!"
		has_all=false
	fi
done < requirements.txt

if [ -f /etc/os-release ]; then
	. /etc/os-release

	if [[ "$NAME" = "Arch Linux" && "$has_all" = false ]]; then
		echo "Get to pacmanning."
	elif [[ "$NAME" = "Gentoo" && "$has_all" = false ]]; then
		echo "Get to emerging."
  elif [[ "$NAME" = "Debian GNU/Linux" && "$has_all" = false ]]; then
    echo "Get to apting."
  elif [ "$has_all" = true ]; then
		echo "You have all the reqs!"
  else
    echo "Use a better distro."
  fi

	

fi
