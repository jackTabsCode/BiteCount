//
//  HomeView.swift
//  BiteCount
//
//  Created by Jack Taylor on 6/23/23.
//

import SwiftUI

struct HomeView: View {
	@Environment(\.scenePhase) private var scenePhase

	@Binding var foods: [Food]
	@Binding var logs: [Log]

	@State private var isPresentingNewFoodView = false
	@State private var isPresentingNewLogView = false
	@State private var showingDeleteAlert = false

	let saveAction: () -> Void

	var totals: Totals {
		var totals = Totals.emptyTotals

		for log in logs {
			var food: Food {
				let calendar = Calendar.current
				return foods.first(where: { $0.id == log.foodId && calendar.isDateInToday(log.date) })!
			}

			totals.protein += log.servings * food.protein
			totals.carbs += log.servings * food.carbs
			totals.fat += log.servings * food.fat
		}

		return totals
	}

	func removeLogs(at offsets: IndexSet) {
		logs.remove(atOffsets: offsets)
	}

	var body: some View {
		NavigationStack {
			List {
				Section(header: Text("Totals")) {
					HStack {
						Label("Calories (Cal)", systemImage: "flame")
						Spacer()
						Text(String(format: "%.1f Cal", totals.calories))
							.opacity(0.5)
					}
					HStack {
						Label("Protein (g)", systemImage: "atom")
						Spacer()
						Text(String(format: "%.1f g", totals.protein))
							.opacity(0.5)
					}
					HStack {
						Label("Carbohydrates (g)", systemImage: "bolt")
						Spacer()
						Text(String(format: "%.1f g", totals.carbs))
							.opacity(0.5)
					}
					HStack {
						Label("Fat (g)", systemImage: "circle.hexagongrid")
						Spacer()
						Text(String(format: "%.1f g", totals.fat))
							.opacity(0.5)
					}
				}
				Section(header: Text("Logs")) {
					ForEach(logs) { log in
						VStack {
							NavigationLink(destination: LogView(foods: $foods, logs: $logs, log: log)) {
								HStack {
									Label(log.name, systemImage: "list.clipboard")
									Spacer()
									Text(log.date.formatted(date: .omitted, time: .shortened))
										.opacity(0.5)
								}
							}
						}
					}
					.onDelete(perform: removeLogs)
				}
			}
			.navigationTitle("Today")
			.toolbar {
				ToolbarItemGroup(placement: .navigationBarTrailing) {
					Menu {
						Button(action: {
							isPresentingNewFoodView = true
						}) {
							Label("New Food", systemImage: "carrot")
						}
						Button(action: {
							isPresentingNewLogView = true
						}) {
							Label("New Log", systemImage: "list.clipboard")
						}
					} label: {
						Image(systemName: "plus")
					}
				}
			}
			.sheet(isPresented: $isPresentingNewFoodView) {
				NewFoodView(isPresentingNewFoodView: $isPresentingNewFoodView, foods: $foods)
			}
			.sheet(isPresented: $isPresentingNewLogView) {
				NewLogView(isPresentingNewLogView: $isPresentingNewLogView, foods: $foods, logs: $logs)
			}
			.onChange(of: scenePhase) { phase in
				if phase == .inactive { saveAction() }
			}
		}
	}
}

struct HomeView_Previews: PreviewProvider {
	static let apple = Food(name: "Apple", weightInGrams: 100, protein: 2, carbs: 10, fat: 1)
	static let banana = Food(name: "Banana", weightInGrams: 200, protein: 3, carbs: 12, fat: 1)

	static var previews: some View {
		HomeView(foods: .constant([
			apple,
			banana,
		]), logs: .constant([
			Log(foodId: apple.id, name: "My Lunch", meal: .breakfast, date: Date(), servings: 1),
		]), saveAction: {})
	}
}
