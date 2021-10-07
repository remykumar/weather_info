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
if [[ -d /home/$USER/weather_info ]]; then
 rm -rf /home/$USER/weather_info
fi

# Get the code from GitHub
git clone https://github.com/remykumar/weather_info.git


# Starting the Build process
echo "Starting Build process.."
sleep 2
# Swtiching to home directory if not already in it
cd ${HOME}

# Remove all the previously used old directories
rm -rf ${BUILD_DIRECTORY}
rm -rf ${DEPLOY_DIRECTORY}

# Make the directories
mkdir ${BUILD_DIRECTORY}
mkdir ${DEPLOY_DIRECTORY}

# Changing to Build directory
cd ${BUILD_DIRECTORY}

# Get the code from the Source directory and move to temp Build directory
cp ${HOME}/weather_info/*.* ${BUILD_DIRECTORY}

echo "Running the Build now.."
sleep 2

echo "Taking care of pre-requistives.Installing Linux packages."
make requires

echo "Creating the Python virtual environment"
make virt_env

echo "DEPLOY and running the code/app"
make run
cp ${BUILD_DIRECTORY}/*.* ${DEPLOY_DIRECTORY}

echo "Clean Up"
make clean
rm -rf ${BUILD_DIRECTORY}

echo "END OF DEPLOYMENT"