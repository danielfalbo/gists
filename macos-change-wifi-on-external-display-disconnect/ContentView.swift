//
//  ContentView.swift
//  HomeSweetHome
//
//  Created by Daniel Falbo on 20/08/2020.
//  Copyright © 2020 Daniel Falbo. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    func execute(script: String) {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = ["/Applications/HomeSweetHome.app/Contents/bin/\(script)"]
        task.launch()
    }

    var body: some View {
        Text("🏡")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onReceive(NotificationCenter.default.publisher(for: NSApplication.didChangeScreenParametersNotification)) { _ in
                self.execute(script: NSScreen.screens.count > 1 ? "connect" : "disconnect")
        }
    }

}
