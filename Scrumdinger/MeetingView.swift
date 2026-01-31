//
//  MeetingView.swift
//  Scrumdinger
//
//  Created by Hira Shrestha on 1/25/26.
//

import SwiftUI
import ThemeKit

struct MeetingView: View {
    var body: some View {
		VStack {
			ProgressView(value: 50, total: 100)
			HStack {
				VStack (alignment: .leading) {
					Text("Seconds elapsed")
					Label("24", systemImage: "hourglass.tophalf.fill")
				}
				Spacer()
				VStack(alignment: .trailing) {
					Text("Seconds remining")
					Label("34", systemImage: "hourglass.bottomhalf.fill")
				}
			}
			.accessibilityElement(children: .ignore)
			.accessibilityLabel("Time remaining")
			.accessibilityValue("10 min")
			Circle()
				.strokeBorder(lineWidth: 24)
			HStack {
				Text("Speaker 1 of 3")
				Spacer()
				Button(action: {}) {
					Image(systemName: "forward.fill")
				}
				.accessibilityLabel("next speaker")
			}
		}
		.padding()
		
    }
}

#Preview {
	MeetingView()
}
