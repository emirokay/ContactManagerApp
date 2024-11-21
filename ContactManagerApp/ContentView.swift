//
//  ContentView.swift
//  ContactManagerApp
//
//  Created by Emir Okay on 5.11.2024.
//

import SwiftUI

struct ContentView: View {
	@StateObject var contactViewModel = ContactViewModel()
	@State var showAddContactView = false
	
	var body: some View {
		NavigationStack {
			List {
				Section("Me") {
					if let meContact = contactViewModel.fetchMeContact() {
						ZStack {
							NavigationLink(destination: ContactDetailView(contactViewModel: contactViewModel, contact: meContact)) {
								EmptyView()
							}.opacity(0.0)
							HStack {
								Text(meContact.firstName)
								Text(meContact.lastName).bold()
								Spacer()
							}
						}
					} else {
						ZStack {
							NavigationLink(destination: AddContactView(contactViewModel: contactViewModel, isMeContact: true)) {
								EmptyView()
							}.opacity(0.0)
							HStack {
								Text("Set up your profile").foregroundColor(.blue)
								Spacer()
							}
						}
					}
				}
				Section("Contacts") {
					if contactViewModel.otherContacts.isEmpty {
						Text("No contacts found")
					} else {
						ForEach(contactViewModel.otherContacts) { contact in
							ZStack{
								NavigationLink(destination: ContactDetailView(contactViewModel: contactViewModel, contact: contact)) { EmptyView() }.opacity(0.0)
								HStack{
									Text(contact.firstName)
									Text(contact.lastName).bold()
									Spacer()
								}
							}
						}
					}
				}
			}
			.navigationTitle("Contacts")
			.sheet(isPresented: $showAddContactView, content: {
				AddContactView(contactViewModel: contactViewModel)
			})
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button {
						showAddContactView.toggle()
					} label: {
						Image(systemName: "plus")
					}
				}
			}
		}
	}
}

#Preview {
	ContentView()
}
