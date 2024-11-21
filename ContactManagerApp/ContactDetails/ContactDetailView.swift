//
//  ContenttView.swift
//  ContactManagerApp
//
//  Created by Emir Okay on 18.11.2024.
//

import SwiftUI

struct ContactDetailView: View {
	@ObservedObject var contactViewModel: ContactViewModel
	@State var isEditing = false
	@State var contact: ContactModel
	
	@State private var showDeleteAlert = false
	@Environment(\.dismiss) var dismiss

	var body: some View {
		NavigationStack {
			ScrollView {
				VStack {
					if isEditing {
						EditContactFieldsView(contact: $contact)

						Button {
							showDeleteAlert = true
						} label: {
							HStack {
								Text("Delete contact")
								Spacer()
							}
						}
						.foregroundStyle(.red)
						.roundedTextFieldStyle()
						.padding(.top)
						.alert("Delete Contact", isPresented: $showDeleteAlert) {
							Button("Delete", role: .destructive) {
								contactViewModel.deleteContact(contact)
								dismiss()
							}
							Button("Cancel", role: .cancel) {}
						} message: {
							Text("Are you sure you want to delete this contact?")
						}
						
					} else {
						ContactDetailsDisplayView(contact: $contact)
					}
				}
				.padding()
			}
			.navigationTitle(isEditing ? "Edit Contact" : "Contact Details")
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button(isEditing ? "Save" : "Edit") {
						if isEditing {
							contactViewModel.saveEditing(contact: contact)
						} else {
							contactViewModel.startEditing(contact: contact)
						}
						isEditing.toggle()
					}
				}
				ToolbarItem(placement: .topBarLeading) {
					if isEditing {
						Button("Cancel", role: .destructive) {
							contact = contactViewModel.originalContact ?? contact
							contactViewModel.cancelEditing()
							isEditing = false
						}
					}
				}
			}
			.navigationBarBackButtonHidden(isEditing ? true : false)
		}
	}
}


#Preview {
	ContactDetailView(contactViewModel: ContactViewModel(), contact: exampleContact[0])
}







