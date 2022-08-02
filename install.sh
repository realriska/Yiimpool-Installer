!/usr/bin/env bash

##############################################################
# author:  Afiniel https://github.com/Afiniel				 #
# date:    2022-08-02										 #
# version: v3.0.0										     #
# website: https://www.afiniel.xyz                           #
#									                         #
# This is the starter for the Yiimp installer				 #
##############################################################

# Set tag version.

if [ -z "${TAG}" ]; then
	TAG=v1.0
fi


# Checks if yiimpool exists or not.
if [ ! -d $HOME/yiimpool ]; then
    
    # Checks if git is installed or not, if not, install it.
	if [ ! -f /usr/bin/git ]; then
		echo Installing git . . .
		apt-get -q -q update
		DEBIAN_FRONTEND=noninteractive apt-get -q -q install -y git < /dev/null
		echo DONE...
		echo
	fi
	
	echo Downloading yiimpool_setup ${TAG}. . .
	git clone \
		-b ${TAG} --depth 1 \
		https://github.com/realriska/yiimpool_setup \
		"$HOME"/yiimpool/install \
		< /dev/null 2> /dev/null
	echo
fi

# Set permission and change directory to it.
cd $HOME/yiimpool/install

# Update it.
sudo chown -R $USER $HOME/yiimpool/install/.git/
if [ "${TAG}" != `git describe --tags` ]; then
	echo Updating Yiimpool Installer to ${TAG} . . .
	git fetch --depth 1 --force --prune origin tag ${TAG}
	if ! git checkout -q ${TAG}; then
		echo "Update failed. Did you modify something in: `pwd`?"
		exit
	fi
	echo
fi

# Start setup script.
bash $HOME/yiimpool/install/start.sh

