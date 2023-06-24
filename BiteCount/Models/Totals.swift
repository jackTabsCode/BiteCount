//
//  Totals.swift
//  BiteCount
//
//  Created by Jack Taylor on 6/24/23.
//

import Foundation

struct Totals {
	var protein: Double
	var carbs: Double
	var fat: Double

	var calories: Double {
		(protein + carbs) * 4 + fat * 9
	}

	static var emptyTotals: Totals {
		Totals(protein: 0, carbs: 0, fat: 0)
	}
}
