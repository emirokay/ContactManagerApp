//
//  Extensions.swift
//  ContactManagerApp
//
//  Created by Emir Okay on 18.11.2024.
//

import SwiftUI

extension View {
	func roundedTextFieldStyle() -> some View {
		self.modifier(RoundedTextFieldModifier())
	}
}

extension String {
	func toDate() -> Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM-dd-yyyy"
		return dateFormatter.date(from: self)
	}
}

extension Date {
	func toString() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM-dd-yyyy"
		return dateFormatter.string(from: self)
	}
}
