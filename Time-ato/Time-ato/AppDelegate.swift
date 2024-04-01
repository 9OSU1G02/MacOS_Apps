//
//  AppDelegate.swift
//  Time-ato
//
//  Created by Quốc Huy Nguyễn on 1/4/24.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    @IBOutlet private var statusMenu: NSMenu!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem?.menu = statusMenu
        statusItem?.button?.title = "Time-ato"
        statusItem?.button?.imagePosition = .imageLeading
        statusItem?.button?.image = NSImage(systemSymbolName: "timer", accessibilityDescription: "Time-ato")
        statusItem?.button?.font = .monospacedSystemFont(ofSize: NSFont.systemFontSize, weight: .regular)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
