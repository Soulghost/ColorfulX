//
//  ColorfulAppApp.swift
//  ColorfulApp
//
//  Created by QAQ on 2023/12/1.
//

import ColorfulX
import SwiftUI

@main
struct ColorfulAppApp: App {
    init() {
        setenv("MTL_HUD_ENABLED", "1", 1)
        DispatchQueue.global().async { leakTest() }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        #if os(macOS)
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unifiedCompact)
        #endif
    }
}

func leakTest() {
    while true {
        var view: AnimatedMulticolorGradientView?
        DispatchQueue.main.asyncAndWait(execute: DispatchWorkItem {
            view = AnimatedMulticolorGradientView(colorSpace: .lch)
        })
        usleep(500_000)
        DispatchQueue.main.asyncAndWait(execute: DispatchWorkItem {
            _ = view
        })
        view = nil
    }
}
