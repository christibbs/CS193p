//
//  Solo_SetApp.swift
//  Shared
//
//  Created by Chris Tibbs on 1/15/21.
//

import SwiftUI

@main
struct Solo_SetApp: App {
    var body: some Scene {
        WindowGroup {
          let viewModel = SetGameViewModel()
          SetGameView(viewModel: viewModel)
        }
    }
}
