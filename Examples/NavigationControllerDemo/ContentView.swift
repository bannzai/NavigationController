//
//  ContentView.swift
//  NavigationControllerDemo
//
//  Created by bannzai on 2024/03/08.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    HomePage()
      .withNavigation()
  }
}

struct HomePage: View {
  @EnvironmentObject var navigationController: NavigationController

  var body: some View {
    VStack {
      Button {
        navigationController.push {
          SecondPage()
        }
      } label: {
        Text("Push")
      }
      .onChange(of: navigationController.path) { oldValue, newValue in
        print("NavigationController.path changed: \(newValue), count: \(newValue.count)")
      }
    }
    .navigationTitle("Home Page")
  }
}

struct SecondPage: View {
  @EnvironmentObject var navigationController: NavigationController

  var body: some View {
    VStack {
      Button {
        navigationController.pop()
      } label: {
        Text("Pop")
      }
      
      Button {
        navigationController.push {
          ThirdPage()
        }
      } label: {
        Text("Push")
      }
    }
    .navigationTitle("Second Page")
  }
}

struct ThirdPage: View {
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var navigationController: NavigationController

  @State var sheetIsPresented = false
  @State var fullScreenCoverIsPresented = false

  var body: some View {
    VStack {
      Button {
        navigationController.pop()
      } label: {
        Text("Pop")
      }

      Button {
        navigationController.popToRoot()
      } label: {
        Text("Pop to root")
      }
      
      Button {
        sheetIsPresented = true
      } label: {
        Text("Sheet")
      }
      .sheet(isPresented: $sheetIsPresented, content: {
        HomePage()
          .withNavigation()
      })
      
      Button {
        fullScreenCoverIsPresented = true
      } label: {
        Text("Full screen cover")
      }
      .fullScreenCover(isPresented: $fullScreenCoverIsPresented, content: {
        HomePage()
          .withNavigation()
          .toolbar {
            ToolbarItem(placement: .topBarLeading) {
              Button {
                dismiss()
              } label: {
                Image(systemName: "xmark")
              }
            }
          }
      })
    }
    .navigationTitle("Third Page")
  }
}

#Preview {
  ContentView()
}
