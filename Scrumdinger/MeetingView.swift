//
//  MeetingView.swift
//  Scrumdinger
//
//  Created by Hira Shrestha on 1/25/26.
//

import SwiftUI

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
			Circle()
				.strokeBorder(lineWidth: 24)
		}
    }
}

#Preview {
	MeetingView()
}
