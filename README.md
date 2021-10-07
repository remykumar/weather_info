# weather_info

**Simple software to display the Weather condition & Temperature of top few US cities**

This repo hosts a quite basic python code which goes out to internet and gets the current weather/temperature of few US cities. The build & deploy script is also in the same repo. 
The purpose of this code is to learn the build & deploy process (using make). 
Here is the usage help: 
Note - Please run with your user account not root (having access to execute all sudo commands without password could help in automation. Refer https://www.cyberciti.biz/faq/linux-unix-running-sudo-command-without-a-password/

Step 1 : Clone the repo from your home directory 
	`git clone https://github.com/remykumar/weather_info.git`

Step 2 : Copy the build_deploy.sh to home directory 
	`cp ~/weather_info/build_deploy.sh ~`

Step 3 : Running the build script 
	`./build_deploy.sh`

Step 4 : Output should look like this - 
```
DEPLOY COMPLETE AND RUNNING THE WEATHER INFO CODE..


Current Weather for few top US Cities @ 2021-10-07 12:31:25 EDT
----------------------------------------------------------------

Chicago,IL: +68°F Mist

Boston,MA: +70°F Partly cloudy

Detroit,MI: +65°F Fog

Minneapolis,MN: +63°F Overcast

Seattle,WA: +48°F Partly cloudy

San Francisco,CA: +57°F Partly cloudy

Atlanta,GA: +73°F Overcast

Houston,TX: +81°F Sunny

Miami,FL: +87°F Partly cloudy

New York,NY: +67°F Partly cloudy

CLEANING UP..

rm -rf virtual_environment/__pycache__
rm -rf virtual_environment
END OF DEPLOYMENT!!

DEPLOYMENT ARTIFACTS CAN BE FOUND HERE - /home/remy/DEPLOY-20211007
```
