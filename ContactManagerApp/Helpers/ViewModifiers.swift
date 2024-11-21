//
//  ViewModifier.swift
//  ContactManagerApp
//
//  Created by Emir Okay on 18.11.2024.
//

import SwiftUI

struct RoundedTextFieldModifier: ViewModifier {
	func body(content: Content) -> some View {
		content
			.padding(15)
			.background {
				RoundedRectangle(cornerRadius: 10, style: .continuous)
					.fill(Color(.systemGray6))
			}
			.foregroundColor(.primary)
			.frame(maxWidth: UIScreen.main.bounds.width - 25, alignment: .leading)
	}
}

