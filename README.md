# BrewDog Beers Coding Challenge Solution
=============================

This is a brief explaination of the solution given to the challenge


Basic Description
--------------------

- The solution follows a VIPER architecture.
- No external frameworks have been used for the App.
- I have been using some helpers which can be found in *utils* directory.


Functionallity description
-----------------------------

- The App starts at the SceneDelegate used in iOS 13. It instatiates the FindBeer calling to use case .findBeer, which setups the FindBeerView, FindBeerPresenter, etc. and presentes the initial controller embebed on a NavigationController.
- The controller (FindBeerView) tells the presenter when it ends viewDidLoad or when the user interact with the UI elements. Therefore the FindBeerPresenter makes the call to the Interactor and creates a new MainViewModel to reconfigure the view.
- The ViewModel is the datasource for the UITableView. It dequeues the cells and configures them with a FindBeerTableViewModel. 
- The network calls are wrapped into an Interactor, which uses two services: CachingService and Networking Service. 
- The CachingService is a simple service using UserDefaults to cache all queries.
- The NetworkingService uses URLSessionDataTasks to download the pages.
- All the Interactor, Services, etc. use protocols to allow decoupling and be easily maintained, tested and/or substituted. 
- Three schemas have been created, so execution, unit testing and UI Testing can be performed on each. These configurations use the xcconfig files at *Config* folder. This setup allows to have different configurations which are available at runtime, use info.plist to be passed and does not need to create diferent products.   

Testing
------

To execute the unit and behaviour tests you will have to change the current schema to the *BrewDog Beers Tests* schema. 

### Unit Tests

- Services: Each service is tested on its own, using mocked json.
- Interactor: The interactor has been tested using CacheService and NetworkService mocks. Therefore we just test the interactor functionallity.

### Behaviour Tests

- Presenter: The presenter behaviour has been tested using the native test framework and some mocked layers.

### UI Testing

To execute the UI  tests you will have to change the current schema to the *BrewDog Beers UITests* schema.

- Although the challenge does not ask for it, a simple UI Test has been included to show basic UI Testing capabilities.
