//
//  BiteCountApp.swift
//  BiteCount
//
//  Created by Jack Taylor on 6/23/23.
//

import SwiftUI

@main
struct BiteCountApp: App {
	@StateObject private var store = Store()
	@State private var errorWrapper: ErrorWrapper?

	var body: some Scene {
		WindowGroup {
			HomeView(foods: $store.foods, logs: $store.logs) {
				Task {
					do {
						try await store.save(newLogs: store.logs, newFoods: store.foods)
					} catch {
						errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
					}
				}
			}
			.task {
				do {
					try await store.load()
				} catch {
					errorWrapper = ErrorWrapper(error: error, guidance: "Will load empty data.")
				}
			}
			.sheet(item: $errorWrapper) {
				store.foods = []
				store.logs = []
			} content: { wrapper in
				ErrorView(errorWrapper: wrapper)
			}
		}
	}
}
