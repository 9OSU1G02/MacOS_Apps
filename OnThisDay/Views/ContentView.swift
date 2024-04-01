/*

 ContentView.swift
 OnThisDay

 Created by Quốc Huy Nguyễn on 29/3/24.

 */

import SwiftUI

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var appState: AppState

  @SceneStorage("eventType") var eventType: EventType?
  @SceneStorage("searchText") var searchText = ""
  @SceneStorage("viewMode") var viewMode: ViewMode = .grid
  @SceneStorage("selectedDate") var selectedDate: String?

  var body: some View {
    NavigationView {
      SidebarView(selection: $eventType)

      if viewMode == .table {
        TableView(tableData: events)
      } else {
        GridView(gridData: events)
      }
    }
    .frame(
      minWidth: 700,
      idealWidth: 1000,
      maxWidth: .infinity,
      minHeight: 400,
      idealHeight: 800,
      maxHeight: .infinity)
    .navigationTitle(windowTitle)
    .toolbar(id: "mainToolbar") {
      Toolbar(viewMode: $viewMode)
    }
    .searchable(text: $searchText)
    .onAppear {
      if eventType == nil {
        eventType = .events
      }
    }
  }

  var events: [Event] {
    appState.dataFor(
      eventType: eventType,
      date: selectedDate,
      searchText: searchText)
  }

  var windowTitle: String {
    var title = "On This Day"

    if let eventType = eventType {
      title += " - \(eventType.rawValue)"
    }

    if let selectedDate = selectedDate {
      title += " - \(selectedDate)"
    } else {
      title += " - Today"
    }

    return title
  }
}

enum ViewMode: Int {
  case grid
  case table
}
