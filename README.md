# Formula 1 Application
This project is a Formula 1 app that integrates the tournament schedule, driver and team details, and highlights. The app is built using MVVM+CLEAN architecture to ensure code structure cleanliness and modularity. The app uses ergast.com and api-sports.io APIs to fetch data.
The app uses UIKit for 80% of the functionality and SwiftUI for 20%. SwiftUI is primarily used for UI and animations, while the rest of the functionality is implemented using UIKit.

# Project Structure
* Model: Contains data structures.
* View: Includes the user interface, presented using UIKit and SwiftUI. UIKit is used for 80% of the app, while SwiftUI is used for 20%, primarily for UI and animations.
* ViewModel: Contains the logic that connects the model and the view.
* Coordinator: Manages view controller transitions and navigation.

Clean Modules
* Common: Contains general code and resources used throughout the application.
* Data: Responsible for data management, including network requests and database operations.
* Network: Handles network communication and API requests.
* Domain: Includes business logic and services defined in the application domain.
* Presentation: Responsible for the user interface and its managing logic.


![CleanArchitectureDependencies](https://github.com/user-attachments/assets/63138f11-7959-45c2-9ee1-56d077cbed63)

# Features
* Home Page: Tournament schedule and news.
* Schedule: Details of upcoming and past races.
* Standings: Rankings of drivers and teams.
* Highlights: Videos and important moments.
* Driver Details: Information and statistics about drivers.
* Team Details: Information and statistics about teams.

# Used APIs

From ergast.com API

* List of all races in the current season.
* Results of the last completed race.
* Driver standings for the current season.
* onstructor standings for the current season.

From api-sports.io API

* Details of circuits.
* Details of teams.
* Details of drivers.

# Prerequisites

* iOS 17.0 or later

# Installation

1. Clone the repository to your local machine:
* git clone[ https://github.com/BakarKharabadze/FinalProject

2. Open the project in Xcode:
* cd formula open Formula.xcodeproj

3. Build and run the project on a simulator or device.
