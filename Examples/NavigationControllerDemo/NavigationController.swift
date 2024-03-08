import SwiftUI

struct NavigationID: Identifiable, Hashable {
  let id: UUID = .init()
}

final class NavigationController: ObservableObject {
  @Published var path: NavigationPath = .init()

  fileprivate var destinations: [NavigationID: () -> any View] = [:]

  func push(id: NavigationID = .init(), @ViewBuilder destination: @escaping () -> some View)  {
    destinations[id] = destination
    path.append(id)
  }

  func pop()  {
    path.removeLast()
  }

  func popToRoot()  {
    while !path.isEmpty {
      path.removeLast()
    }
  }
}

struct WithNavigationModifier: ViewModifier {
  @StateObject var navigationController = NavigationController()

  func body(content: Content) -> some View {
    NavigationStack(path: $navigationController.path) {
      content
        .navigationDestination(for: NavigationID.self) { routeID in
          if let destination = navigationController.destinations[routeID] {
            AnyView(destination())
          }
        }
    }
    .environmentObject(navigationController)
  }
}

extension View {
  func withNavigation() -> some View {
    modifier(WithNavigationModifier())
  }
}
