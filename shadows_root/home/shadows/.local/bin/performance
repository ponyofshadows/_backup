#!/bin/bash
pcstate=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
if [ "$pcstate" = "powersave" ]; then
  echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
  # echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
  # echo performance | sudo tee /sys/firmware/acpi/platform_profile
elif [ "$pcstate" = "performance" ]; then
  echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
  # echo balance_performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
  # echo balanced | sudo tee /sys/firmware/acpi/platform_profile
else
  echo "unexpected cpu0 state" >&2
fi
