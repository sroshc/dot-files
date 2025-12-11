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

  if [[ "$has_all" = false ]]; then

    if [[ "$NAME" = "Arch Linux" ]]; then
      echo "Get to pacmanning."
    elif [[ "$NAME" = "Gentoo" ]]; then
      echo "Get to emerging."
    elif [[ "$NAME" = "Debian GNU/Linux" ]]; then
      echo "Get to apting."
    else
      echo "Use a better distro."
    fi
      
  else
    echo "You have all the reqs!"
  fi
	

fi
