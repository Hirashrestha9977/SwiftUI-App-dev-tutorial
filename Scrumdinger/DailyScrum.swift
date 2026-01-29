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
	let attendees: [String]
	let lengthInminutes: Int
	let theme: Theme

	init(id: UUID = UUID(), title: String, attendees: [String], lengthInminutes: Int, theme: Theme) {
		self.id = id
		self.title = title
		self.attendees = attendees
		self.lengthInminutes = lengthInminutes
		self.theme = theme
	}
}
