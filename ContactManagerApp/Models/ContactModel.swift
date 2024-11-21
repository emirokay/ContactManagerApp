//
//  Contact.swift
//  ContactManagerApp
//
//  Created by Emir Okay on 5.11.2024.
//

import Foundation

struct ContactModel: Identifiable, Codable {
	var id = UUID()
	var profileImageData: Data
	var firstName: String
	var lastName: String
	var notes: String
	var phoneNumber: String
	var email: String
	var address: String
	var birthdate: String
	
}

let exampleContact = [ContactModel(profileImageData: Data(), firstName: "John", lastName: "Doe", notes: "Met at the tech conference last year. Interested in collaborating on projects.", phoneNumber: "12345678901", email: "john.doe@example.com", address: "123 Main St, Springfield, USA", birthdate: "14 nov 2024"), ContactModel(profileImageData: Data(), firstName: "John", lastName: "Doe", notes: "Met at the tech conference last year. Interested in collaborating on projects.", phoneNumber: "12345678901", email: "john.doe@example.com", address: "123 Main St, Springfield, USA", birthdate: "14 nov 2024"), ContactModel(profileImageData: Data(), firstName: "John", lastName: "Doe", notes: "Met at the tech conference last year. Interested in collaborating on projects.", phoneNumber: "12345678901", email: "john.doe@example.com", address: "123 Main St, Springfield, USA", birthdate: "14 nov 2024")]
