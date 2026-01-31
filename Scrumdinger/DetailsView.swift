//
//  DetailsView.swift
//  Scrumdinger
//
//  Created by Hira Shrestha on 1/31/26.
//

import SwiftUI
import ThemeKit

struct DetailsView: View {
	let scrum: DailyScrum
    var body: some View {
		List {
			Section(header: Text("Meeting Info"), footer: Text("end of meeting")) {
				NavigationLink(destination: MeetingView()) {
					Label("Start Meeting", systemImage: "timer")
						.font(.headline)
						.foregroundColor(.accentColor)
				}
				HStack {
					Label("length", systemImage: "clock")
					Spacer()
					Text("\(scrum.lengthInminutes) min")
				}
				.accessibilityElement(children: .combine)
				HStack {
					Label("Theme", systemImage: "paintpalette")
					Spacer()
					Text(scrum.theme.name)
						.padding(4)
						.foregroundColor(scrum.theme.accentColor)
						.background(scrum.theme.mainColor)
						.cornerRadius(4)

				}
				.accessibilityElement(children: .combine)
			}
			Section(header: Text("Attendees")) {
				ForEach(scrum.attendees) { attendee in
					Label(attendee.name, systemImage: "person")
				}
			}
		}
		.navigationTitle(scrum.title)
    }
}

#Preview {
	NavigationStack {
		DetailsView(scrum: DailyScrum.sampleData[0])
	}
}
