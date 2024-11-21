//
//  Untitled.swift
//  ContactManagerApp
//
//  Created by Emir Okay on 18.11.2024.
//

import SwiftUI

struct EditContactFieldsView: View {
	@Binding var contact: ContactModel
	@StateObject var imagePicker = ImagePickerHelper()
	@State private var showImagePicker = false
	
	var body: some View {
		VStack {
			imagePicker.image
				.resizable()
				.clipShape(Circle())
				.frame(width: 120, height: 120)
				.overlay(alignment: .bottomTrailing) {
					Image(systemName: "plus")
						.font(.title3)
						.fontWeight(.semibold)
						.foregroundColor(.white)
						.padding(10)
						.background(.blue, in: Circle())
				}
				.onTapGesture {
					showImagePicker = true
				}
				.padding()
			
			VStack(spacing: 20) {
				TextField("First name", text: $contact.firstName)
					.roundedTextFieldStyle()
				
				TextField("Last name", text: $contact.lastName)
					.roundedTextFieldStyle()
				
				TextField("Phone number", text: $contact.phoneNumber)
					.roundedTextFieldStyle()
					.keyboardType(.numberPad)
				
				TextField("Notes", text: $contact.notes)
					.roundedTextFieldStyle()
				
				TextField("Email", text: $contact.email)
					.roundedTextFieldStyle()
				
				TextField("Address", text: $contact.address)
					.roundedTextFieldStyle()
				
				DatePicker("Birthdate", selection: Binding(
					get: {
						contact.birthdate.toDate() ?? Date()
					},
					set: { newDate in
						contact.birthdate = newDate.toString()
					}),
					in: ...Date.now,
					displayedComponents: .date
				)
				.roundedTextFieldStyle()

			}
		}
		.onAppear{
			if let image = UIImage(data: contact.profileImageData), contact.profileImageData.count > 0 {
				imagePicker.image = Image(uiImage: image)
				imagePicker.imageData = contact.profileImageData
			}
		}
		.onChange(of: imagePicker.image, { oldValue, newValue in
			contact.profileImageData = imagePicker.imageData
		})
		.photosPicker(isPresented: $showImagePicker, selection: $imagePicker.imageSelection, matching: .images)
	}
}

#Preview {
	EditContactFieldsView(contact: .constant(exampleContact[0]))
}
