//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by Hira Shrestha on 1/26/26.
//

import Foundation
import ThemeKit

struct DailyScrum: Identifiable {
	let id: UUID
	let title: String
	let attendees: [Attendee]
	let lengthInminutes: Int
	let theme: Theme

	init(id: UUID = UUID(), title: String, attendees: [String], lengthInminutes: Int, theme: Theme) {
		self.id = id
		self.title = title
		self.attendees = attendees.map{ Attendee(name: $0)}
		self.lengthInminutes = lengthInminutes
		self.theme = theme
	}

	struct Attendee: Identifiable {
		let id: UUID
		let name: String

		init(id: UUID = UUID(), name: String) {
			self.id = id
			self.name = name
		}
	}
}
