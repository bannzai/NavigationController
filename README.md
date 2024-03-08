
# NavigationController

`NavigationController` is a Swift Package designed to simplify and efficiently manage navigation within SwiftUI applications. Leveraging SwiftUI's `NavigationStack` and `NavigationPath`, it aims to make the implementation of navigation flows between screens as straightforward as possible. This package is created with the goal of


## Features

- Simple API for implementing navigation transitions
- Utilizes SwiftUI's `NavigationStack` and `NavigationPath` for navigation management
- Supports sharing navigation state across multiple screens
- Facilitates programmatic navigation between views

## Installation

### Swift Package Manager

`NavigationController` can be added to your project using the Swift Package Manager. In Xcode, select "File" > "Swift Packages" > "Add Package Dependency..." and enter the following repository URL:


## Usage

To use `NavigationController`, apply the `WithNavigationModifier` modifier to the SwiftUI view you want to manage navigation for. Then, control the navigation between screens using instances of `NavigationController`.

```swift
struct ContentView: View {
  var body: some View {
    RootView()
      .withNavigation()
  }
}

struct RootView: View {
  // Retrieve navigationController via EnvironmentObject
  @EnvironmentObject var navigationController: NavigationController

  var body: some View {
    VStack {
      // Use navigationController ...
    }
  }
}
```

To push a screen:

```swift
Button {
  navigationController.push { 
    YourDestinationView() 
  }
} label: {
  Text("Push")
}
```

To pop a screen

```swift
Button {
  navigationController.pop()
} label: {
  Text("Pop")
}
```

Edit path directly. For example edit path and pop.

```swift
Button {
  navigationController.path.removeLast()
} label: {
  Text("Edit path and pop")
}
```

## LICENSE
**NavigationController** is released under the MIT License. For more details, please see the LICENSE file.



