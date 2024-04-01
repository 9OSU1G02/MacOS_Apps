//
//  TableView.swift
//  OnThisDay
//
//  Created by Quốc Huy Nguyễn on 1/4/24.
//

import SwiftUI

struct TableView: View {
  var tableData: [Event]
  @AppStorage("showTotals") var showTotals = true

  @State private var sortOrder = [KeyPathComparator(\Event.year)]

  // For single selections:
  @State private var selectedEventID: UUID?

  // For multiple selections:
  // @State private var selectedEventID: Set<UUID> = []

  var body: some View {
    VStack {
      HStack {
        Table(
          sortedTableData,
          selection: $selectedEventID,
          sortOrder: $sortOrder) {
            TableColumn("Year", value: \.year) {
              Text($0.year)
            }
            .width(min: 50, ideal: 60, max: 100)

            TableColumn("Title", value: \.text)
        }

        if let selectedEvent = selectedEvent {
          EventView(event: selectedEvent)
            .frame(width: 250)
        } else {
          Text("Select an event for more details…")
            .font(.title3)
            .padding()
            .frame(width: 250)
        }
      }

      if showTotals {
        Text("\(tableData.count) \(tableData.count == 1 ? "entry" : "entries") displayed.")
          .padding(.bottom, 8)
      }
    }
  }

  var sortedTableData: [Event] {
    return tableData.sorted(using: sortOrder)
  }

  var selectedEvent: Event? {
    guard let selectedEventID = selectedEventID else {
      return nil
    }

    let event = tableData.first {
      $0.id == selectedEventID
    }
    return event
  }
}

struct TableView_Previews: PreviewProvider {
  static var previews: some View {
    TableView(tableData: [Event.sampleEvent])
  }
}

