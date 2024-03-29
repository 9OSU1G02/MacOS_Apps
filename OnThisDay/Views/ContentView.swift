//
//  ContentView.swift
//  OnThisDay
//
//  Created by Quốc Huy Nguyễn on 29/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: EventType? = .events
    @EnvironmentObject var appState: AppState
    var events: [Event] {
        appState.dataFor(eventType: selection)
    }

    var windowTitle: String {
        if let eventType = selection {
            return "On This Day - \(eventType.rawValue)"
        }
        return "On This Day"
    }

    var body: some View {
        NavigationView {
            SidebarView(selection: $selection)
            GridView(gridData: events)
        }
        .frame(
            minWidth: 700,
            idealWidth: 1000,
            maxWidth: .infinity,
            minHeight: 400,
            idealHeight: 800,
            maxHeight: .infinity)
        .navigationTitle(windowTitle)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
