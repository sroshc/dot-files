#!/bin/bash

cpu_temp="N/A"
gpu_temp="N/A"
last_temp_update=0
temp_update_interval=5 # in seconds 

while true; do
  current_time=$(date +%s)

  if (( current_time - last_temp_update >= temp_update_interval )); then
    cpu_temp=$(sensors | grep "Package id 0:" | awk '{print $4}')
    [[ -z "$cpu_temp" ]] && cpu_temp="N/A"

    gpu_temp="+$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader).0°C"
    [[ -z "$gpu_temp" ]] && gpu_temp="N/A"

    last_temp_update=$current_time
  fi
  
  ram_used=$(free -h | grep "Mem" | awk '{print $3}')

  date=$(date +'%A, %b %d')
  time=$(date +'%I:%M %p')

  battery_path="/sys/class/power_supply/BAT0"
  if [[ -d "$battery_path" ]]; then
    battery_level=$(<"$battery_path/capacity")
    charging=$(<"/sys/class/power_supply/AC/online")
    
    battery="${battery_level}%"
    if [[ $charging == 0 ]]; then
      energy_now=$(cat $battery_path/energy_now)
      power_now=$(cat $battery_path/power_now)
      time_till_empty=$(echo "scale=1; $energy_now / $power_now" | bc)

      battery="$battery  $time_till_empty hours"  
    else
      battery="$battery (charging)" 
    fi
  else
    battery="no battery"
  fi

  ssid=$(nmcli -t -f active,ssid dev wifi | awk -F: '/yes/ {print $2}')
  ip=$(hostname --ip-address | awk '{print $1}')
  
  if [[ -z "$ssid" ]]; then
    network="not connected"
  else
    network="$ssid $ip"
  fi
  
  echo "$date | $time | $battery | CPU: $cpu_temp  GPU: $gpu_temp | $ram_used | $network"
  sleep 1
done
