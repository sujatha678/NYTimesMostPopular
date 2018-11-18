# NYTimesMostPopular

## Version

1.0

## Build and Runtime Requirements
+ Xcode 9.2 or later
+ iOS 11.2 or later

## Configuring the Project

Configuring the Xcode project requires a few steps in Xcode to get up and running like Pod libraries

1) Run the pods before compiling the code for the safe execution

2) Ensure Automatic is chosen for the Provisioning Profile setting in the Code Signing section of Target > Build Settings for the following Targets:

- NYTimesMostPoular
- NYTimesMostPoularTests

3) Ensure iOS Developer is chosen for the Code Signing Identity setting in the Code Signing section of Target > Build Settings for the following Targets:

- NYTimesMostPoular
- NYTimesMostPoularTests

4) If the certificates and profiles are generated use the same for the following the targets

- NYTimesMostPoular
- NYTimesMostPoularTests

5) Run the application in iPhone or iPad simulator or device to have the list of results from service

Note: Update the project settings if any errors while compiling

## About NYTimesMostPoular

NYTimesMostPoular is an iOS project to view most viewed Articles from Newyork Times. In this project, the user can see lists of articles recent to 1, 7 and 30days.

## Written in Swift

This project is written in Swift. It lists the most viewd articles from the Newtork times from the the latest of 1, 7 and 30 days. The detail of the selected Article will be populated in the WKWebview in the detail screen.

APIManager class will handle the service requets and the data managing things like parsing using the JSONDecoder by using Alamofire(ThirdParty) whic is introduced in Swift4 for the minimal code implementation and easy to use yet effective way of development

Network manager is used for the network status check and an Observer is added whic trigger to present an alert to show user about the lost internet connection.

Helper class includes the Utils used to trigger alert , conversion of date format, start/stop activityindicator and calculating height of cell.

## Application Architecture

The NYTimesMostPoular project includes iOS app targets

### iOS

This project version of NYTimesMostPoular follows the Model-View-Controller (MVC) design pattern and uses modern app development practices including Storyboards and Auto Layout. Also in this version of NYTimesMostPopular, the user manages multiple lists using a table view implemented in the ViewController class. Details of the selcted data is populated using the WKWebview and used its delegate methods to check the status of the webview loading in the ArticleDetailViewController class

## Swift Features

The NYTimesMostPoular sample leverages many features unique to Swift, including the following:

#### JSONDecoder

The Articles, ArticleData, ImageData, ImageDetails all are confiriming to the Decodable protocol to easily and effectively bind the JSON response getting from Newyork Times services.

#### Enums

API links, ServiceType - json and xml, PossibleDays - 1, 7 and 30 are implemented using enum to have a specified Raw value along with the features available in Enum swift


#### Completion Handlers

NYTimesMostPoular - APIManger will delcare the public completion handlers which can be used anywhere in the app and that named
CompletionHandler.

## Unit Tests

NYTimesMostPoular has unit tests written NYTimesMostPoular, APIManager, ArticleDetailViewController. These tests are in the NYTimesMostPoularTests group. To run the unit tests, select either the NYTimesMostPoular scheme in the Scheme menu. Then hold the Run button down and select the "Test" option, or press Command+u to run the tests.
MockResponse.json will also hold the mock JSON data to test the network scenorios
Code coverage is also done for the respective classes implemented and as we know 100% code coverage is tentitative based on the requirement of the app and the scenorios handling thats why third party libraries and codes are ignored as of now due to time constraint. Alerts class is custom template made long before hence not used, so 70% of its code is covered but its scalable and reusable with the existing code, whenever we need all the method it can be tested using Unit testing. To check the code coverage select Report navigator - select latest test report and select the code coverage tab in the middle. We can see the class and method wise coverage with the expand collapse option.
