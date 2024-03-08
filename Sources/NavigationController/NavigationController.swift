import SwiftUI

public struct NavigationID: Identifiable, Hashable {
  public let id: UUID

  public init() {
    id = .init()
  }
}

public final class NavigationController: ObservableObject {
  @Published public var path: NavigationPath = .init()

  fileprivate var destinations: [NavigationID: () -> any View] = [:]

  public func push(id: NavigationID = .init(), @ViewBuilder destination: @escaping () -> some View)  {
    destinations[id] = destination
    path.append(id)
  }

  public func pop()  {
    path.removeLast()
  }

  public func popToRoot()  {
    while !path.isEmpty {
      path.removeLast()
    }
  }
}

public struct WithNavigationModifier: ViewModifier {
  @StateObject var navigationController = NavigationController()

  public func body(content: Content) -> some View {
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
  public func withNavigation() -> some View {
    modifier(WithNavigationModifier())
  }
}
