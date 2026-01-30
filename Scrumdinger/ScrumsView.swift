//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Hira Shrestha on 1/29/26.
//

import SwiftUI
import ThemeKit

struct ScrumsView: View {

	let scrums: [DailyScrum]

    var body: some View {
		NavigationStack {
			List(scrums) { scrum in
				NavigationLink( destination: Text(scrum.title)) {
					CardView(scrum: scrum)
				}
				.listRowBackground(scrum.theme.mainColor)
			}
			.navigationTitle("Daily scrum")
			.toolbar {
				Button(action: {}) {
					Image(systemName: "plus")
				}
				.accessibilityLabel("New Scrum")
			}
		}
    }
}

#Preview {
	ScrumsView(scrums: DailyScrum.sampleData)
}
