//
//  CleanHarborsiOSCTApp.swift
//  CleanHarborsiOSCT
//
//  Created by Puja Gogineni on 2/15/24.
//

import SwiftUI

@main
struct CleanHarborsiOSCTApp: App {
    var body: some Scene {
        WindowGroup {
            GridView(viewModel: GridViewModel())
        }
    }
}
