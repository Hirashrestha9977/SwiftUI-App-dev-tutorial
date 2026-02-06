//
//  DetailsEditView.swift
//  Scrumdinger
//
//  Created by Hira Shrestha on 2/2/26.
//

import SwiftUI

struct DetailsEditView: View {
	@State private var scrum = DailyScrum.emptyScrum

    var body: some View {
		Form {
			Section("Meeting Info") {
				TextField("Title", text: $scrum.title)
				HStack {
					Slider(value: $scrum.lengthInminutesDouble, in: 5...30, step: 1)
					Text("Length")
				}
				Spacer()
				Text("\(scrum.lengthInminutes) minutes")
			}
			Section("Attendee") {
				ForEach(scrum.attendees) { attendee in
					Text(attendee.name)

				}
			}
		}
    }
}

#Preview {
    DetailsEditView()
}
