#!/bin/bash

# Countdown from input to 0 with 1s delay
countDown () {
	for i in $(seq 0 $* | sort -nr)
	do
		echo "### $i ###"
		sleep 1
	done
	
}

# Print input in between spacers
printSpacer () {
	printf "#############################################\n\n"
	printf "* $*"
	printf "\n\n#############################################\n"
}

# Update repos and upgrade base packages
updatePkg () {
printSpacer "Updating repo and upgrading packages..."
#apt update -y; apt upgrade -y
printSpacer "Done updating repo and upgrading packages."
}

# Install new internal packages
installIntPkg () {
	printSpacer "Installing new internal packages..."
	apt install $(cat ./aptPackages.list)
	printSpacer "Done installing new internal packages."
}




# Main function, used to keep everything clean and tidy
main () {
	cat ./cmotd.txt
	countDown 5
	updatePkg
	installIntPkg
}
main
