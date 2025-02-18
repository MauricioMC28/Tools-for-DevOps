#!/bin/bash

check_unzip() {
	if command -v unzip &> /dev/null
	then
		echo "unzip is already installed."
	else
		echo "unzip is not installed. Installing..."
		sudo apt-get update
		sudo apt-get install -y unzip
		echo "unzip has been installed"
	fi
}

echo "Checking if unzip is installed..."
check_unzip

echo "Script execution completed."
