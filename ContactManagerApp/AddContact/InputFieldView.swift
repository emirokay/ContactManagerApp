//
//  InputField.swift
//  ContactManagerApp
//
//  Created by Emir Okay on 18.11.2024.
//

import SwiftUI

struct InputFieldView: View {
	var placeholder: String
	@Binding var text: String
	var keyboardType: UIKeyboardType = .default

	var body: some View {
		TextField(placeholder, text: $text)
			.roundedTextFieldStyle()
			.keyboardType(keyboardType)
	}
}
