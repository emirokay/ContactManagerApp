//
//  DisplayContactDetails.swift
//  ContactManagerApp
//
//  Created by Emir Okay on 19.11.2024.
//

import SwiftUI

struct ContactDetailsDisplayView: View {
	@Binding var contact: ContactModel
	
	var body: some View {
		VStack {
			
			if let uiImage = UIImage(data: contact.profileImageData), contact.profileImageData.count > 0 {
				Image(uiImage: uiImage)
					.resizable()
					.clipShape(Circle())
					.frame(width: 120, height: 120)
					.padding(.top)
			} else {
				ImagePickerHelper.nullProfile
					.resizable()
					.clipShape(Circle())
					.frame(width: 120, height: 120)
					.padding(.top)
			}
			
			HStack {
				Text(contact.firstName)
					.foregroundColor(.primary)
				Text(contact.lastName)
					.bold()
					.foregroundColor(.primary)
			}
			.font(.title2)
			.padding(10)
			
			ContactDetailRowView(title: "Phone number", content: contact.phoneNumber)
			ContactDetailRowView(title: "Notes", content: contact.notes)
			ContactDetailRowView(title: "Email", content: contact.email)
			ContactDetailRowView(title: "Address", content: contact.address)
			ContactDetailRowView(title: "Birthdate", content: contact.birthdate)
		}
	}
}
