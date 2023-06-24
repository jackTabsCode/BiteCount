//
//  Log.swift
//  BiteCount
//
//  Created by Jack Taylor on 6/23/23.
//

import Foundation

enum Meal: String, Codable, CaseIterable, Identifiable {
	case breakfast
	case lunch
	case dinner
	case dessert
	case snack

	var name: String {
		rawValue.capitalized
	}

	var id: String {
		name
	}
}

struct Log: Identifiable, Codable {
	var id: UUID
	var foodId: UUID

	var name: String
	var meal: Meal
	var date: Date
	var servings: Double

	init(id: UUID = UUID(), foodId: UUID, name: String, meal: Meal, date: Date, servings: Double) {
		self.id = id
		self.foodId = foodId
		self.name = name
		self.meal = meal
		self.date = date
		self.servings = servings
	}
}
