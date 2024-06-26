//
//  AppDelegate.swift
//  Time-ato
//
//  Created by Quốc Huy Nguyễn on 1/4/24.
//

import Cocoa
import SwiftUI
import LaunchAtLogin

@main
class AppDelegate: NSObject, NSApplicationDelegate {
  var statusItem: NSStatusItem?
  var menuManager: MenuManager?

  @IBOutlet weak var statusMenu: NSMenu!
  @IBOutlet weak var startStopMenuItem: NSMenuItem!
  @IBOutlet weak var launchOnLoginMenuItem: NSMenuItem!

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    statusItem = NSStatusBar.system.statusItem(
      withLength: NSStatusItem.variableLength)

    statusItem?.menu = statusMenu

    statusItem?.button?.title = "Time-ato"
    statusItem?.button?.imagePosition = .imageLeading
    statusItem?.button?.image = NSImage(
      systemSymbolName: "timer",
      accessibilityDescription: "Time-ato")

    statusItem?.button?.font = NSFont.monospacedDigitSystemFont(
      ofSize: NSFont.systemFontSize,
      weight: .regular)

    menuManager = MenuManager(statusMenu: statusMenu)
    statusMenu.delegate = menuManager
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }

  func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

  @IBAction func startStopTask(_ sender: Any) {
    menuManager?.taskManager.toggleTask()
  }

  @IBAction func showEditTasksWindow(_ sender: Any) {
      let hostingController = NSHostingController(rootView: EditTasksView())
      let window = NSWindow(contentViewController: hostingController)
      window.title = "Edit Tasks"
      
      let controller = NSWindowController(window: window)
      NSApp.activate(ignoringOtherApps: true)
      controller.showWindow(nil)
  }

  @IBAction func toggleLaunchOnLogin(_ sender: Any) {
      LaunchAtLogin.isEnabled.toggle()
  }

    @IBAction func showAbout(_ sender: NSMenuItem) {
        NSApp.orderFrontStandardAboutPanel(nil)
    }
    
    
  func updateMenu(title: String, icon: String, taskIsRunning: Bool) {
    statusItem?.button?.title = title
    statusItem?.button?.image =
    NSImage(systemSymbolName: icon, accessibilityDescription: title)

    updateMenuItemTitles(taskIsRunning: taskIsRunning)

    if menuManager?.menuIsOpen == true {
      menuManager?.updateMenuItems()
    }
  }

  func updateMenuItemTitles(taskIsRunning: Bool) {
    if taskIsRunning {
      startStopMenuItem.title = "Mark Task as Complete"
    } else {
      startStopMenuItem.title = "Start Next Task"
    }
      launchOnLoginMenuItem.state = LaunchAtLogin.isEnabled ? .on : .off
  }
}
