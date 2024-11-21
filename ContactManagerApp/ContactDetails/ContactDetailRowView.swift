//
//  ContactDetailRow.swift
//  ContactManagerApp
//
//  Created by Emir Okay on 19.11.2024.
//

import SwiftUI

struct ContactDetailRowView: View {
	let title: String
	let content: String
	private let rowWidth = UIScreen.main.bounds.width - 25
	
	var body: some View {
		VStack(alignment: .leading, spacing: 5) {
			Text(title)
				.bold()
				.font(.subheadline)
				.foregroundColor(.primary)
				.frame(maxWidth: rowWidth, alignment: .leading)
			
			Text(content)
				.frame(maxWidth: rowWidth - 25, alignment: .leading)
				.padding(15)
				.background {
					RoundedRectangle(cornerRadius: 10, style: .continuous)
						.fill(Color(.systemGray6))
				}
				.foregroundColor(.primary)
		}
		.frame(maxWidth: rowWidth, alignment: .leading)
		.padding(.horizontal, 10)
		.padding(.vertical, 5)
	}
}
