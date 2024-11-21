//
//  BirthDatePicker.swift
//  ContactManagerApp
//
//  Created by Emir Okay on 18.11.2024.
//

import SwiftUI

struct BirthdatePickerView: View {
	@Binding var showDatePicker: Bool
	@Binding var birthdate: Date

	var body: some View {
		HStack {
			Image(systemName: !showDatePicker ? "plus.circle.fill" : "minus.circle.fill")
				.foregroundStyle(!showDatePicker ? .green : .red)
				.onTapGesture { showDatePicker.toggle() }
			Text("Birthdate")
			DatePicker("", selection: $birthdate, in: ...Date.now, displayedComponents: .date)
				.opacity(!showDatePicker ? 0 : 1)
		}
		.animation(.easeInOut(duration: 0.15), value: showDatePicker)
		.roundedTextFieldStyle()
	}
}
