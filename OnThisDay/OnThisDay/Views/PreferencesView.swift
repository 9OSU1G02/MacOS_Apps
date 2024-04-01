//
//  PreferencesView.swift
//  OnThisDay
//
//  Created by Quốc Huy Nguyễn on 1/4/24.
//

import SwiftUI

struct PreferencesView: View {
    var body: some View {
        TabView(content: {
            ShowView()
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Show")
                }
            ApperanceView()
                .tabItem {
                    Image(systemName: "sun.min")
                    Text("Appearance")
                }
        })
        .frame(width: 200, height: 150)
        .navigationTitle("Settings")
    }
}

struct ShowView: View {
    @AppStorage("showTotals") var showTotals = true
    @AppStorage("showDeaths") var showDeaths = true
    @AppStorage("showBirths") var showBirths = true

    var body: some View {
        VStack(alignment: .leading) {
            Toggle(isOn: $showTotals) {
                Text("Show Totals")
            }
            Toggle(isOn: $showDeaths) {
                Text("Show Deaths")
            }
            Toggle(isOn: $showBirths) {
                Text("Show Births")
            }
        }
    }
}

#Preview {
    ShowView()
        .frame(width: 250, height: 100)
}

struct ApperanceView: View {
    @AppStorage("displayMode") var displayMode = DisplayMode.auto
    var body: some View {
        Picker("", selection: $displayMode) {
            ForEach(DisplayMode.allCases, id: \.self) {
                Text($0.rawValue)
                    .tag($0)
            }
        }
        .pickerStyle(.radioGroup)
    }
}

#Preview(body: {
    ApperanceView()
        .frame(width: 250, height: 100)
})
