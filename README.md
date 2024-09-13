
# Bootcamp Task App

## Overview

I have included all the tasks to be covered as mentioned in the PS.

## Features

### 1. Fetch Random Images
The app starts with three images scrollable horizontally. These images are fetched from some pinterest account.

### 2. List All Page
It lists all the json data in form of list builder which was to be fetched from the given API.   https://fakerapi.it/api/v1/companies?_seed=12456 
I have used http package of flutter to send GET requests.


### 3. Live Feed Page
I have used a real time api in this task which provides real-time weather information for a user-specified location.
- **Data Source:** Weather data is fetched from the WeatherAPI (https://api.weatherapi.com) using a specified location query entered in the text field, please enter the exact name of the city to fetch correctly.
- **UI Design:** The page displays current weather conditions, including temperature, weather condition, wind speed, humidity, and more.
- **User Interaction:** Users can refresh the weather data by scrolling down the page. This triggers a new request to fetch the latest weather information.

Note: I have used a hardcoded key to access the api which may expire in some days.

### 4. Notifications Page
I have also implemented the notification functionality. It basically uses the local notifications package. 
-  It currently display notification only when we click on the floating action button on homepage. 
-  The notifications include hardcoded messages.



## How to Run the App
1. Clone the Repository
2. Run "flutter pub get" to get the required dependencies.

Also DevCamp.apk file is uploaded alonwith the code. Download it and install to run the app directly.

