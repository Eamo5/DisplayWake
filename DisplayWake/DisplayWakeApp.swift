//
//  DisplayWakeApp.swift
//  DisplayWake
//
//  Created by Eamon Powell on 10/9/2024.
//

import SwiftUI

@main
struct DisplayWakeApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        Settings {}
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?

    func applicationDidFinishLaunching(_ notification: Notification) {
        setupStatusItem()
    }

    private func setupStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "flashlight.on.fill", accessibilityDescription: "Flash light icon")
            button.action = #selector(flashScreen)
        }
    }

    @objc func flashScreen() {
        let screenRect = NSScreen.main?.frame ?? NSRect.zero

        let flashWindow = NSWindow(contentRect: screenRect,
                                  styleMask: [],
                                  backing: .buffered,
                                  defer: false)
        flashWindow.level = .modalPanel
        flashWindow.backgroundColor = NSColor.white
        flashWindow.isOpaque = true
        flashWindow.alphaValue = 1.0

        // Show the window
        flashWindow.makeKeyAndOrderFront(nil)

        // Remove the window after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            flashWindow.orderOut(nil)
        }
    }
}
