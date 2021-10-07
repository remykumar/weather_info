#!/usr/bin/python3

# Author : Remy Kumar Arumugham
# Date : 07-Oct 2021
# Code to display the current weather condition of few US cities

# Code uses python library package requests
# This code refers another code/data file for getting the cities list; this is imported here
import requests
from datetime import datetime
import cities_metadata

# Get length of the Cities' list(array)
numCities = len(cities_metadata.cities)
print("\nCurrent Weather for few top US Cities @ "+datetime.now().astimezone().strftime("%Y-%m-%d %H:%M:%S %Z"))
print("----------------------------------------------------------------\n")
#print(cities_metadata.get_state("Chicago"))

# Iterate through the list of cities and get the temperature/weather condition by reaching out to a site on Internet
for i in range(numCities):
 city = cities_metadata.cities[i]
 #print(city)
 url = f"https://wttr.in/{city}?format=%l:+%t %C"
 r = requests.get(url,headers={'Cache-Control': 'no-cache'})
 if r.status_code == 200:
  cityState = city+","+cities_metadata.get_state(city)
  print(f'{r.text.replace(city, cityState)}\n')
 else:
  print("An error occurred in getting Current Weather! Please try again later, code={}".format(r.status_code))