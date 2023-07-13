#!/bin/bash

# Countdown from input to 0 with 1s delay
getVars () {
	printf "Username: " ; read inUser

}

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
	printf "\n\n#############################################\n\n"
}

# Update repos and upgrade base packages
updatePkg () {
	printSpacer "Updating repo and upgrading packages..."
	sudo apt update -y; sudo apt upgrade -y
	printSpacer "Done updating repo and upgrading packages."
}

# Install new internal packages
installIntPkg () {
	printSpacer "Installing new internal packages..."
	sudo apt install $(cat ./aptPackages.list)
	printSpacer "Done installing new internal packages."
}

modBashrc () {
	printSpacer "Modifying .bashrc file..."
	cat bashrc.txt >> /home/$inUser/.bashrc
	sdiff bashrc.txt /home/$inUser/.bashrc
	source "/home/$inUser/.bashrc"
	printSpacer "Done modifying .bashrc file."
}

# Main function, used to keep everything clean and tidy
main () {
	cat ./cmotd.txt
	if [[ "$USER" == "root" ]]; then echo run this as your normal user ; exit 2; fi
	getVars
	echo $inUser
	countDown 5
	updatePkg
	installIntPkg
	modBashrc
}
main
