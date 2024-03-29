//
//  SidebarView.swift
//  OnThisDay
//
//  Created by Quốc Huy Nguyễn on 29/3/24.
//

import SwiftUI

struct SidebarView: View {
    @Binding var selection: EventType?
    var body: some View {
        List(selection: $selection) {
            Section("TODAY") {
                ForEach(EventType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
        }
        .listStyle(.sidebar)
    }
}

#Preview {
    SidebarView(selection: .constant(.births))
        .frame(width: 200)
}
