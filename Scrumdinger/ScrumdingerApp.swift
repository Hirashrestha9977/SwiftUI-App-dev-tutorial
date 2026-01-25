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
	let theme: Theme = Theme.sky
    var body: some Scene {
		WindowGroup {
			MeetingView()
				.background(theme.mainColor)
		}
    }
}
