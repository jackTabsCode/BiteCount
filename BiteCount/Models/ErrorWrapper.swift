//
//  ErrorWrapper.swift
//  BiteCount
//
//  Created by Jack Taylor on 6/23/23.
//

import Foundation

struct ErrorWrapper: Identifiable {
	let id: UUID
	let error: Error
	let guidance: String

	init(id: UUID = UUID(), error: Error, guidance: String) {
		self.id = id
		self.error = error
		self.guidance = guidance
	}
}
