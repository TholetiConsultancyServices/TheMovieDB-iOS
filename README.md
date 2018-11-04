# TheMovieDB iOS Test App

An iPhone app for iOS 10 that displays:
1.shows the movies that are now playing in a grid style view(/movie/now_playing)
2. Selecting a movie should show a detail view of the movie (/movie/{movie_id})
3. If a movie is part of a collection of movies, from the detail view you should be able to see the
other movies in the collection and selecting them should link through to the detail view for
that movie. (/collection/{collection_id})

## How to Run, Build and Test

- The project can be run using Xcode 9.4.1 and built/tested using the standard Xcode build (⌘B) and test (⌘U) commands.
- Local movies list file is embedded in the test target to run the tests without relying on the network. 

## Summary of implementation details:

- Developed the App using Xcode 9.4.1 and Swift 4.1.

- No third party libraries are used.

- Main focus on implementing right architecture, design patterns and performance of the App.

- Implemented UI modules using storyboards, uistackview and auto layouts.

- Followed MVVM based architecture- Model,View(View&ViewController) and ViewModel

- Used Protocol Oriented Progrmming approach wherever it is possible

- Used dependency injection across the App to facilitate the unit testing of the classes.

- Implemented unit tests using XCTestCase and Mock Objects.

- Used NSURLSession for network operations.

- Used Swfit Codable for parsing JSON data.

- Used Reachability  for network availability check.

- Added refresh Data option
- Added Image caching support using URLCache


## Further Improvements

The following are some of the improvements to the project that should be made given more time:

- Eye-catching UI elements
- Use UITextView for show long movie overview
- Landscape support
- Persist movies data to display in offline mode
-Display more movie details
- More unit tests for a complete coverage
- UI tests

