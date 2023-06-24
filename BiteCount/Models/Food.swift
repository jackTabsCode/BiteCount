//
//  FoodModel.swift
//  BiteCount
//
//  Created by Jack Taylor on 6/23/23.
//

import Foundation

struct Food: Identifiable, Codable {
	let id: UUID

	var name: String
	var weightInGrams: Double

	var protein: Double
	var carbs: Double
	var fat: Double

	var calories: Double {
		(protein + carbs) * 4 + fat * 9
	}

	init(
		id: UUID = UUID(),
		name: String,
		weightInGrams: Double,
		protein: Double,
		carbs: Double,
		fat: Double
	) {
		self.id = id
		self.name = name
		self.weightInGrams = weightInGrams
		self.protein = protein
		self.carbs = carbs
		self.fat = fat
	}

	static var emptyFood: Food {
		Food(
			name: "",
			weightInGrams: 0,
			protein: 0,
			carbs: 0,
			fat: 0
		)
	}
}

