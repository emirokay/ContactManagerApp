//
//  ImagePicker.swift
//  ContactManagerApp
//
//  Created by Emir Okay on 18.11.2024.
//

import SwiftUI
import PhotosUI

@MainActor
class ImagePickerHelper: ObservableObject {
	@Published var image: Image = Image("nullProfile")
	static public let nullProfile: Image = Image("nullProfile")
	@Published var imageData: Data = Data()
	
	@Published var imageSelection : PhotosPickerItem? {
		didSet {
			if let imageSelection {
				Task {
					try await loadTransferable(from: imageSelection)
				}
			}
		}
	}
	
	func loadTransferable(from imageSelection: PhotosPickerItem?) async throws {
		do {
			if let data = try await imageSelection?.loadTransferable(type: Data.self) {
				imageData = data
				if let uiImage = UIImage(data: data) {
					self.image = Image(uiImage: uiImage)
				}
			}
		} catch {
			print(error.localizedDescription)
			image = ImagePickerHelper.nullProfile
		}
	}
	
}
