# Dota Heros App

# Introduction
This project is a simple app that displays a list of heroes and allows the user to view more detailed information about each hero. The app fetches data about the heroes from an API and stores it in an array of HeroStats objects.

# API
This application was developed using the OpenDota API (https://api.opendota.com/api/heroStats).

# ViewController

The ViewController class is responsible for managing the table view that displays the list of heroes, as well as an activity indicator that is shown while the data is being fetched.

The fetchData method is used to retrieve data about the heroes from an API. The data is then decoded into an array of HeroStats objects and stored in the heroes property.

The table view has the ViewController class set as its data source and delegate. This allows the ViewController to provide the table view with the data it needs to display and handle user interactions with the table view cells. The tableView(_:numberOfRowsInSection:) method specifies the number of rows in the table view, and the tableView(_:cellForRowAt:) method provides the table view with a cell to display for each row.

The tableView(_:didSelectRowAt:) method is called when a user taps on a table view cell. It instantiates a DetailViewController and presents it modally to display more detailed information about the selected hero.

# DetailViewController

The DetailViewController class is responsible for displaying detailed information about a hero, including its name and attack type, as well as an image of the hero. It has a hero property that is set by the ViewController before it is presented, and it uses this property to populate its views with the hero's data.

# UIImageView Extension

The UIImageView extension provides a method for downloading an image from a URL and displaying it in the image view. The downloaded(from:) method takes a URL and optionally a content mode as parameters, and it sets the image of the image view to the image at the URL using the specified content mode.


# Screenshots

<img src="https://i.imgur.com/CAsveiZ.png" width="200">

<img src="https://i.imgur.com/6k3NRxX.png" width="200"/>





