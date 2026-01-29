//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Hira Shrestha on 1/25/26.
//

import SwiftUI
import ThemeKit

@main
struct ScrumdingerApp: App {
    var body: some Scene {
		WindowGroup {
			ScrumsView(scrums: DailyScrum.sampleData)
		}
    }
}
