//
//  LogView.swift
//  BiteCount
//
//  Created by Jack Taylor on 6/23/23.
//

import SwiftUI

struct LogView: View {
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

	@Binding var foods: [Food]
	@Binding var logs: [Log]

	var log: Log
	var food: Food {
		foods.first(where: { $0.id == log.foodId })!
	}

	var body: some View {
		Form {
			Section(header: Text("Basics")) {
				HStack {
					Text("Log Name")
					Spacer()
					Text(log.name)
						.opacity(0.5)
				}
				HStack {
					Text("Date")
					Spacer()
					Text(log.date.formatted())
						.opacity(0.5)
				}
			}
			Section(header: Text("Macros")) {
				HStack {
					Text("Protein (g)")
					Spacer()
					Text(String(format: "%.1f", food.protein))
						.opacity(0.5)
				}
				HStack {
					Text("Carbohydrates (g)")
					Spacer()
					Text(String(format: "%.1f", food.protein))
						.opacity(0.5)
				}
				HStack {
					Text("Fat")
					Spacer()
					Text(String(format: "%.1f", food.protein))
						.opacity(0.5)
				}
			}
		}
		.navigationTitle(log.name)
		.toolbar {
			ToolbarItemGroup(placement: .destructiveAction) {
				Button(role: .destructive) {
					logs.removeAll(where: { $0.id == log.id })

					self.presentationMode.wrappedValue.dismiss()
				} label: {
					Text("Delete")
				}
			}
		}
	}
}

struct LogView_Previews: PreviewProvider {
	static let apple = Food(name: "Apple", weightInGrams: 100, protein: 2, carbs: 10, fat: 1)
	static let banana = Food(name: "Banana", weightInGrams: 200, protein: 3, carbs: 12, fat: 1)

	static var previews: some View {
		LogView(
			foods: .constant([apple]),
			logs: .constant([]),
			log: Log(foodId: apple.id, name: "My Lunch", meal: .breakfast, date: Date(), servings: 1)
		)
	}
}
