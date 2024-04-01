//
//  OnThisDayApp.swift
//  OnThisDay
//
//  Created by Quốc Huy Nguyễn on 29/3/24.
//

import SwiftUI

@main
struct OnThisDayApp: App {
  @StateObject var appState = AppState()
  @AppStorage("displayMode") var displayMode = DisplayMode.auto

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(appState)
        .onAppear {
          DisplayMode.changeDisplayMode(to: displayMode)
        }
        .onChange(of: displayMode, { _, newValue in
            DisplayMode.changeDisplayMode(to: newValue)
        })
    }
    .commands {
      Menus()
    }
      Settings {
          PreferencesView()
      }
  }
}
