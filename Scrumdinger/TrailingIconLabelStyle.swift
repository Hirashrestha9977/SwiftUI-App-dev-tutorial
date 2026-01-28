//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by Hira Shrestha on 1/28/26.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
	func makeBody(configuration: Configuration) -> some View {
		return HStack {
			configuration.icon
			configuration.title
		}
	}
}

extension LabelStyle where Self == TrailingIconLabelStyle {
	static var trailingIcon: Self { Self()}
}
