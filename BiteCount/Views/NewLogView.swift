//
//  NewLogView.swift
//  BiteCount
//
//  Created by Jack Taylor on 6/24/23.
//

import SwiftUI

struct NewLogView: View {
	@Binding var isPresentingNewLogView: Bool
	@Binding var foods: [Food]
	@Binding var logs: [Log]

	@State private var name = ""
	@State private var servings: Double = 1
	@State private var mealType: Meal = .breakfast

	@State private var selectedFood: Food?

	var body: some View {
		NavigationStack {
			Form {
				Section(header: Text("Basics")) {
					TextField("Name", text: $name)
					HStack {
						Text("Servings")
						Spacer()
						TextField("1", value: $servings, format: .number)
							.multilineTextAlignment(.trailing)
							.opacity(0.5)
					}
					Picker("Meal Type", selection: $mealType) {
						ForEach(Meal.allCases) { meal in
							Text(meal.name)
								.tag(meal)
						}
					}
				}
				Section(header: Text("Food")) {
					ForEach(foods) { food in
						Button {
							selectedFood = food
						} label: {
							HStack {
								Text(food.name)
								Spacer()
								if selectedFood?.id == food.id {
									Image(systemName: "checkmark")
								}
							}
						}
					}
				}
			}
			.toolbar {
				ToolbarItemGroup(placement: .cancellationAction) {
					Button {
						isPresentingNewLogView = false
					} label: {
						Text("Cancel")
					}
				}
				ToolbarItemGroup(placement: .confirmationAction) {
					Button {
						switch selectedFood {
						case .none:
							return
						case let .some(theFood):
							logs.append(Log(
								foodId: theFood.id,
								name: name,
								meal: mealType,
								date: Date(),
								servings: servings
							))
						}

						isPresentingNewLogView = false
					} label: {
						Text("Log")
							.bold()
					}
					.disabled(selectedFood == nil || name == "")
				}
			}
			.navigationTitle("New Log")
			.navigationBarTitleDisplayMode(.inline)
		}
	}
}

struct NewLogView_Previews: PreviewProvider {
	static let apple = Food(name: "Apple", weightInGrams: 100, protein: 2, carbs: 10, fat: 1)
	static let banana = Food(name: "Banana", weightInGrams: 200, protein: 3, carbs: 12, fat: 1)

	static var previews: some View {
		NewLogView(isPresentingNewLogView: .constant(true), foods: .constant([apple, banana]), logs: .constant([]))
	}
}
