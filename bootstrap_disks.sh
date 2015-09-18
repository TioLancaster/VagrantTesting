#!/usr/bin/env bash

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install parted -y

#Add labels
sudo parted -a optimal /dev/sdb mklabel gpt
sudo parted -a optimal /dev/sdc mklabel gpt

#Create partitions
sudo parted -a optimal -- /dev/sdb unit compact mkpart primary ext4 "1" "-1"
sudo parted -a optimal -- /dev/sdc unit compact mkpart primary ext4 "1" "-1"

#format partions
sudo mkfs.ext4 /dev/sdb1 -F
sudo mkfs.ext4 /dev/sdc1 -F
