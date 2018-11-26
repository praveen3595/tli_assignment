# MVC Project
A simple MVC project

### Running the Project
1. Open `NYTimes.xcodeproj` in Xcode
2. Build and run!



### Dependecies
No dependences required.

### Best Practices
* MVC Design Pattern
* Class with Single Responsibility
* FolderStructure - Seperation on layers
* Asynchronous Network calls
* Caching Images
* Callbacks using Closure
* Enumeration - Extensions - Optional Binding


### Project Overview
 
* `NewsListTableViewController.swift` - initial scene with NewsFeeds
* `DetailNewsViewController.swift` - scene contains detailed News
 
* `News.swift` - Data model with the information we want to show in the app.
* `NYTimesAPI.swift` - Responsible for creating URL's and Validate API response data
* `NewsStore.swift` - Important class acts as Interface for providing data for any viewcontroller

* `NewsListTableViewCell.swift` - customcell for newsFNewsFeeds 

* `NetworkManager.swift` - Handles the Request for NYTimes API



### Unit Test
* `NYTimesTests.swift` - Unit test class with simple DataModel initializationTest.
Note - For this scope only one testcase written more Testcase  can be done by mocking urlsession with  protocols

### CodeCoverage
Code Coverage enabled in Xcode and Investigated in report navigator
Note - Third party libraries can be used to generate reports
