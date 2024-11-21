//
//  ContactViewModel.swift
//  ContactManagerApp
//
//  Created by Emir Okay on 5.11.2024.
//

import Foundation

class ContactViewModel: ObservableObject {
	@Published var contacts: [ContactModel]
	@Published var currentContact: ContactModel?
	@Published var originalContact: ContactModel?
	@Published var meContactId: UUID? {
		didSet {
			saveMeContactId()
		}
	}
	var otherContacts: [ContactModel] {
		contacts.filter { $0.id != meContactId }
	}
	
	private let storageKey = "SavedContacts"
	private let meContactIdKey = "MeContactId"
	
	init() {
		if let data = UserDefaults.standard.data(forKey: storageKey),
		   let decoded = try? JSONDecoder().decode([ContactModel].self, from: data) {
			contacts = decoded
		} else {
			contacts = []
		}
		
		if let meIdString = UserDefaults.standard.string(forKey: meContactIdKey),
		   let meId = UUID(uuidString: meIdString) {
			meContactId = meId
		}
	}
	
	private func save() {
		if let encoded = try? JSONEncoder().encode(contacts) {
			UserDefaults.standard.set(encoded, forKey: storageKey)
		}
	}
	
	private func saveMeContactId() {
		if let meContactId {
			UserDefaults.standard.set(meContactId.uuidString, forKey: meContactIdKey)
		} else {
			UserDefaults.standard.removeObject(forKey: meContactIdKey)
		}
	}
	
	func reloadContacts() {
		if let data = UserDefaults.standard.data(forKey: storageKey),
		   let decoded = try? JSONDecoder().decode([ContactModel].self, from: data) {
			contacts = decoded
		}
	}
	
	func add(_ contact: ContactModel, isMeContact: Bool = false) {
		contacts.append(contact)
		save()
		
		if isMeContact {
			meContactId = contact.id
		}
	}
	
	func updateContact(_ updatedContact: ContactModel) {
		if let index = contacts.firstIndex(where: { $0.id == updatedContact.id }) {
			contacts[index] = updatedContact
			save()
		}
	}
	
	func deleteContact(_ contact: ContactModel) {
		contacts.removeAll { $0.id == contact.id }
		save() 
	}
	
	func startEditing(contact: ContactModel) {
		currentContact = contact
		originalContact = contact
	}
	
	func cancelEditing() {
		if let original = originalContact {
			updateContact(original)
		}
		currentContact = nil
		originalContact = nil
	}
	
	func saveEditing(contact: ContactModel) {
		updateContact(contact)
		currentContact = nil
		originalContact = nil
	}
	
	func isFormValid(firstName: String, phoneNumber: String) -> Bool {
		!firstName.isEmpty && !phoneNumber.isEmpty
	}
	
	func fetchMeContact() -> ContactModel? {
		guard let meContactId else { return nil }
		return contacts.first { $0.id == meContactId }
	}
	
	func setMeContact(_ contact: ContactModel) {
		meContactId = contact.id
	}
	
	func createContact(profileImageData: Data, firstName: String, lastName: String, notes: String, phoneNumber: String, email: String, address: String, birthdate: Date, showDatePicker: Bool, isMeContact: Bool = false) {
		let date = showDatePicker ? birthdate.formatted(.dateTime.day().month().year()) : ""
		
		let newContact = ContactModel(
			profileImageData: profileImageData,
			firstName: firstName,
			lastName: lastName,
			notes: notes,
			phoneNumber: phoneNumber,
			email: email,
			address: address,
			birthdate: date
		)
		
		add(newContact, isMeContact: isMeContact)
	}
}














//class ContactViewModel: ObservableObject {
//	@Published var contacts: [Contact]
//	@Published var currentContact: Contact?
//	@Published var originalContact: Contact?
//	
//	let storageKey = "SavedContacts"
//	let meContactIdKey = "MeContactId"
//	
//	init() {
//		if let data = UserDefaults.standard.data(forKey: storageKey) {
//			if let decoded = try? JSONDecoder().decode([Contact].self, from: data) {
//				contacts = decoded
//				return
//			}
//		}
//		contacts = []
//	}
//	
//	func reloadContacts() {
//		if let data = UserDefaults.standard.data(forKey: storageKey) {
//			if let decoded = try? JSONDecoder().decode([Contact].self, from: data) {
//				contacts = decoded
//				return
//			}
//		}
//	}
//	
//	private func save() {
//		if let encoded = try? JSONEncoder().encode(contacts) {
//			UserDefaults.standard.set(encoded, forKey: storageKey)
//		}
//	}
//	
//	func add(_ contact: Contact) {
//		contacts.append(contact)
//		save()
//	}
//	
//	func startEditing(contact: Contact) {
//		currentContact = contact
//		originalContact = contact
//	}
//	
//	func cancelEditing() {
//		if let original = originalContact {
//			updateContact(original)
//		}
//		currentContact = nil
//		originalContact = nil
//	}
//	
//	func updateContact(_ updatedContact: Contact) {
//		if let index = contacts.firstIndex(where: { $0.id == updatedContact.id }) {
//			contacts[index] = updatedContact
//			save()
//			reloadContacts()
//		}
//	}
//	
//	func saveEditing(contact: Contact) {
//		updateContact(contact)
//		currentContact = nil
//		originalContact = nil
//	}
//	
//	func isFormValid(firstName: String, phoneNumber: String) -> Bool {
//		!firstName.isEmpty && !phoneNumber.isEmpty
//	}
//	
//	func createContact(profileImageData: Data, firstName: String, lastName: String, notes: String, phoneNumber: String, email: String, address: String, birthdate: Date, showDatePicker: Bool) {
//		let date = {
//			if showDatePicker {
//				return birthdate.formatted(.dateTime.day().month().year())
//			}
//			return ""
//		}
//		
//		let newContact = Contact(profileImageData: profileImageData, firstName: firstName, lastName: lastName, notes: notes, phoneNumber: phoneNumber, email: email, address: address, birthdate: date())
//		add(newContact)
//	}
//}
//
//
//
