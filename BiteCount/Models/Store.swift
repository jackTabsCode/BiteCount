//
//  Store.swift
//  BiteCount
//
//  Created by Jack Taylor on 6/23/23.
//

import Foundation

@MainActor
class Store: ObservableObject {
	@Published var logs: [Log] = []
	@Published var foods: [Food] = []

	private static func fileURL(prefix: String) throws -> URL {
		try FileManager.default.url(
			for: .documentDirectory,
			in: .userDomainMask,
			appropriateFor: nil,
			create: false
		)
		.appendingPathComponent("\(prefix).data")
	}

	func load() async throws {
		let logTask = Task<[Log], Error> {
			let fileURL = try Store.fileURL(prefix: "logs")
			guard let data = try? Data(contentsOf: fileURL) else {
				return []
			}
			let loadedLogs = try JSONDecoder().decode([Log].self, from: data)
			return loadedLogs
		}

		let foodTask = Task<[Food], Error> {
			let fileURL = try Store.fileURL(prefix: "foods")
			guard let data = try? Data(contentsOf: fileURL) else {
				return []
			}
			let loadedFoods = try JSONDecoder().decode([Food].self, from: data)
			return loadedFoods
		}

		let loadedLogs = try await logTask.value
		let loadedFoods = try await foodTask.value

		logs = loadedLogs
		foods = loadedFoods
	}

	func save(newLogs: [Log], newFoods: [Food]) async throws {
		let task = Task {
			let logData = try JSONEncoder().encode(newLogs)
			let logFileURL = try Store.fileURL(prefix: "logs")
			try logData.write(to: logFileURL)

			let foodData = try JSONEncoder().encode(newFoods)
			let foodFileURL = try Store.fileURL(prefix: "foods")
			try foodData.write(to: foodFileURL)
		}

		_ = try await task.value
	}
}
