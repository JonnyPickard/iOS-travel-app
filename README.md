iOS travel app tech test
========================

![screenshot](https://github.com/JonnyPickard/iOS-travel-app/blob/master/screenshots/screenshotSimulator1.png)

About
-----
This is an iOS travel app tech test built with Swift 3.0

Prerequisites
-------------
- Cocoapods
- Xcode >= 8.0

To Install
----------
- Make sure Cocoapods is installed and set up
- Note: to install cocoapods run ``$ gem install cocoapods``
- Note: to set up cocoapods run ``$ pod setup``
- Run ``$ pod install`` from the directory to install dependencies
- Open the ``.xcworkspace`` file with Xcode
- Run simulator or run tests
- Enjoy!

Challenge Briefing:
------------------
We would like you to develop the following app to display a list of holiday deals.  

We’re in the process of migrating our codebase to Swift, so please complete this exercise using Swift (2.x or 3). Feel free to use any libraries or frameworks that you prefer (and be prepared to explain your choices of course).  

The app will use a UITabBar containing two options. One for showing the settings and one for the home screen (not necessarily in this order). Each of these options should contain a UINavigationController.   

The home screen should show a list of holiday deals for various destinations.  

The deals will be retrieved by calling an API. You can either mock this API or make use of our real live one. If you choose to mock the API call, you can use the following data:

``
    "HotelsByChildDestination": {
      "10|10030": {
        "Title": "Majorca, Ibiza & Menorca",
        "Count": 178,
        "MinPrice": 428.96,
        "Position": 1   // Use this field to order the list.
      },
      "10|10031": {
        "Title": "Canary Islands",
        "Count": 106,
        "MinPrice": 555,
        "Position": 0
      },
      "10|10049": {
        "Title": "Spain",
        "Count": 99,
        "MinPrice": 49.99,
        "Position": 2
      }
    }
``

If you prefer to make a real API call you can use the following URL:  

``
[Hidden for privacy]
``

and POST the following JSON request in the body using Content-Type of application/json:  

``
{"CheckInDate":"2017-01-10T00:00:00.000Z", "Flexibility":3, "Duration":7, "Adults":2, "DomainId":1, "CultureCode":"en-gb", "CurrencyCode":"GBP", "OriginAirports":["LHR","LCY","LGW","LTN","STN","SEN"], "FieldFlags":8143571, "IncludeAggregates":true}
``

You should receive JSON in that same structure as described above.

Each item in the list should look like this one:

![item](https://github.com/JonnyPickard/iOS-travel-app/blob/master/screenshots/image1.png)

Please notice that HotelsByChildDestination is a dictionary where the key takes the format of type|id. The two numbers in the key (for example 10|10030) are used to retrieve the background image using the following URL format:  

``
[Hidden for privacy]
``

While retrieving the list of deals, show a loading indicator. Dismiss it when the call returns.

In case the API returns an error show an alert to show the error and allow the user to retry.

The settings screen can be empty.

TODO
-----

- More robust error handling with more coverage
- More testing for more complete test coverage
- View layout refinements
- UITesting
- Refactoring
