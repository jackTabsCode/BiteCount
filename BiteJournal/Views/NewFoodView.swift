//
//  LogView.swift
//  BiteJournal
//
//  Created by Jack Taylor on 6/23/23.
//

import MapKit
import SwiftUI

struct NewFoodView: View {
	@State private var food = Food.emptyFood
	@Binding var isPresentingNewFoodView: Bool

	@Binding var foods: [Food]

	var body: some View {
		NavigationStack {
			Form {
				Section(header: Text("Basics")) {
					TextField("Name", text: $food.name)
					HStack {
						Text("Weight (g)")
						Spacer()
						TextField("0", value: $food.weightInGrams, format: .number)
							.multilineTextAlignment(.trailing)
							.opacity(0.5)
							.keyboardType(.decimalPad)
					}
				}
				Section(header: Text("Macros")) {
					HStack {
						Text("Protein (g)")
						Spacer()
						TextField("0", value: $food.protein, format: .number)
							.multilineTextAlignment(.trailing)
							.opacity(0.5)
							.keyboardType(.decimalPad)
					}
					HStack {
						Text("Carbohydrates (g)")
						Spacer()
						TextField("0", value: $food.carbs, format: .number)
							.multilineTextAlignment(.trailing)
							.opacity(0.5)
							.keyboardType(.decimalPad)
					}
					HStack {
						Text("Fat (g)")
						Spacer()
						TextField("0", value: $food.fat, format: .number)
							.multilineTextAlignment(.trailing)
							.opacity(0.5)
							.keyboardType(.decimalPad)
					}
				}
			}

			.toolbar {
				ToolbarItemGroup(placement: .cancellationAction) {
					Button {
						isPresentingNewFoodView = false
					} label: {
						Text("Cancel")
					}
				}
				ToolbarItemGroup(placement: .confirmationAction) {
					Button {
						foods.append(food)

						isPresentingNewFoodView = false
					} label: {
						Text("Add")
							.bold()
					}
				}
			}
			.navigationTitle("New Food")
			.navigationBarTitleDisplayMode(.inline)
		}
	}
}

struct NewFoodView_Previews: PreviewProvider {
	static var previews: some View {
		NewFoodView(isPresentingNewFoodView: .constant(true), foods: .constant([]))
	}
}
