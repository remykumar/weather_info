#!/bin/bash

# Build script for building the python code in a virtual environment
# Author : Remy Kumar Arumugham
# Date : 07-Oct 2021

# Read me
# Go to the home directory of the user (like /home/remy), place the script there and execute the script like ./build_deploy.sh
# Run using your own user account (not root) from your home directory. Please make sure your account has sudo access to root.
# The script has been tested for Ubuntu - Other Operating Systems could see some unwarranted errors.

BUILD_DIRECTORY=/tmp/temp_build_directory
SRC_DIRECTORY=${HOME}/weather_info
DEPLOY_DIRECTORY=$HOME/DEPLOY-$(date '+%Y%m%d')

echo -e "\nChecking if the script is in home directory of the user - /home/$USER \n"
sleep 1
if [[ `pwd` != /home/$USER ]]; then
 echo -e "\nNot running from home directory of user. Please place the script in the home directory of the user & execute.\n"
 exit
fi

echo -e "\nRunning from the current user's ($USER) home directory.\n"
sleep 3
if [ $USER = root ]; then
 echo -e "!!!!Running with root user; existing script. Please run with your normal user account!!!!\n"
 echo -e "Also, Please make sure your user has sudo to root since we are installing softwares/packages via sudo.\n"
 exit
else
 echo -e "Switching to $USER home directory - /home/$USER\n"
 sleep 2
 cd /home/$USER
fi

# Remove the old code directory and use git to download everytime
echo -e "Removing old cloned directory /home/$USER/weather_info\n"
if [[ -d /home/$USER/weather_info ]]; then
 rm -rf /home/$USER/weather_info
fi

# Install git & Get the code from GitHub
echo -e "Installing git and cloning code from github\n"
sudo apt-get install git -y
git clone https://github.com/remykumar/weather_info.git


# Starting the Build process
echo -e "\nSTARTING BUILD PROCESS..\n"
sleep 2
# Swtiching to home directory if not already in it
cd ${HOME}

# Remove all the previously used old directories
echo -e "REMOVING OLD BUILD AND DEPLOY DIRECTORIES..\n"
rm -rf ${BUILD_DIRECTORY}
rm -rf ${DEPLOY_DIRECTORY}

# Make the directories
echo -e "CREATING NEW BUILD AND DEPLOY DIRECTORIES..\n"
mkdir ${BUILD_DIRECTORY}
mkdir ${DEPLOY_DIRECTORY}

# Changing to Build directory
echo -e "CHANGING WORK/CURRENT DIRECTORY TO BUILD DIRECTORY..\n"
cd ${BUILD_DIRECTORY}

# Get the code from the Source directory and move to temp Build directory
cp ${HOME}/weather_info/* ${BUILD_DIRECTORY}

echo -e "RUNNING THE BUILD NOW..\n"
sleep 2

echo -e "Taking care of pre-requistives.INSTALLING LINUX PACKAGES..\n"
make requires

echo -e "\nCREATING PYTHON VIRTUAL ENVIRONMENT..\n"
make virt_env

echo -e "\nDEPLOY COMPLETE AND RUNNING THE WEATHER INFO CODE..\n"
sleep 3
make run

echo -e "CLEANING UP..\n"
cp ${BUILD_DIRECTORY}/*.* ${DEPLOY_DIRECTORY}
make clean
rm -rf ${BUILD_DIRECTORY}

echo -e "END OF DEPLOYMENT!!\n"

echo -e "DEPLOYMENT ARTIFACTS CAN BE FOUND HERE - ${DEPLOY_DIRECTORY}\n"
