//
//  SidebarView.swift
//  OnThisDay
//
//  Created by Quốc Huy Nguyễn on 29/3/24.
//

import SwiftUI

struct SidebarView: View {
    @Binding var selection: EventType?

    @EnvironmentObject var appState: AppState

    @AppStorage("showTotals") var showTotals = true
    @SceneStorage("selectedDate") var selectedDate: String?
    @AppStorage("showDeaths") var showDeaths = true
    @AppStorage("showBirths") var showBirths = true
    var validTypes: [EventType] {
        // 2
        var types = [EventType.events]
        // 3
        if showBirths {
            types.append(.births)
        }
        if showDeaths {
            types.append(.deaths)
        }
        // 4
        return types
    }

    var body: some View {
        VStack {
            List(selection: $selection) {
                Section(selectedDate?.uppercased() ?? "TODAY") {
                    ForEach(validTypes, id: \.self) { type in
                        Text(type.rawValue)
                            .badge(
                                showTotals
                                    ? appState.countFor(eventType: type, date: selectedDate)
                                    : 0)
                    }
                }

                Section("AVAILABLE DATES") {
                    ForEach(appState.sortedDates, id: \.self) { date in
                        Button {
                            selectedDate = date
                        } label: {
                            HStack {
                                Text(date)
                                Spacer()
                            }
                        }
                        .controlSize(.large)
                        .modifier(DateButtonViewModifier(selected: date == selectedDate))
                    }
                }
            }
            .listStyle(.sidebar)

            Spacer()
            DayPicker()
        }
        .frame(minWidth: 220)
    }
}

struct DateButtonViewModifier: ViewModifier {
    var selected: Bool

    func body(content: Content) -> some View {
        if selected {
            content
                .buttonStyle(.borderedProminent)
        } else {
            content
        }
    }
}

