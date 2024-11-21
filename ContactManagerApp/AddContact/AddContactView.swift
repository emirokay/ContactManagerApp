//
//  AddContactView.swift
//  ContactManagerApp
//
//  Created by Emir Okay on 18.11.2024.
//

import SwiftUI

struct AddContactView: View {
	@ObservedObject var contactViewModel: ContactViewModel
	@Environment(\.dismiss) var dismiss
	@Environment(\.colorScheme) var colorScheme
	
	@State var showImagePicker = false
	@StateObject var imagePicker = ImagePickerHelper()
	
	@State private var showAlert = false
	@State private var alertTitle = ""
	@State private var alertMessage = ""
	@State private var showDatePicker = false

	@State var firstName = ""
	@State var lastName = ""
	@State var notes = ""
	@State var phoneNumber = ""
	@State var email = ""
	@State var address = ""
	@State var birthdate = Date()
	@State var isMeContact = false

	var body: some View {
		NavigationStack {
			ScrollView {
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
						.onTapGesture { showImagePicker.toggle() }

					VStack(spacing: 20) {
						InputFieldView(placeholder: "First name", text: $firstName)
						InputFieldView(placeholder: "Last name", text: $lastName)
						InputFieldView(placeholder: "Phone number", text: $phoneNumber, keyboardType: .numberPad)
						InputFieldView(placeholder: "Email", text: $email)
						InputFieldView(placeholder: "Address", text: $address)
						InputFieldView(placeholder: "Notes", text: $notes)

						BirthdatePickerView(showDatePicker: $showDatePicker, birthdate: $birthdate)
					}
				}
				.padding()
			}
			.navigationTitle(isMeContact ? "Create your card" : "Add New Contact")
			.navigationBarTitleDisplayMode(.inline)
			.navigationBarBackButtonHidden(isMeContact ? true : false)
			.photosPicker(isPresented: $showImagePicker, selection: $imagePicker.imageSelection, matching: .images)
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button("Save") {
						if contactViewModel.isFormValid(firstName: firstName, phoneNumber: phoneNumber) {
							
							contactViewModel.createContact(
								profileImageData: imagePicker.imageData,
								firstName: firstName,
								lastName: lastName,
								notes: notes,
								phoneNumber: phoneNumber,
								email: email,
								address: address,
								birthdate: birthdate,
								showDatePicker: showDatePicker,
								isMeContact: isMeContact
							)
							dismiss()
						} else {
							alertTitle = "Missing Information"
							alertMessage = "Please enter both a first name and phone number."
							showAlert = true
						}
					}
				}
				ToolbarItem(placement: .topBarLeading) {
					Button("Cancel", role: .destructive) { dismiss() }
						.foregroundStyle(.red)
				}
			}
			.background(colorScheme == .dark ? .black : .white)
			.alert(alertTitle, isPresented: $showAlert, actions: {}, message: { Text(alertMessage) })
		}
	}
}

#Preview {
	AddContactView(contactViewModel: ContactViewModel())
}
