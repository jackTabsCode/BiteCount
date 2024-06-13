//
//  MacroView.swift
//  BiteJournal
//
//  Created by Jack Taylor on 6/13/24.
//

import SwiftUI

struct MacroView: View {
	var name: String
	var unit: String
	var image: String
	var amount: Double
	
    var body: some View {
		HStack {
			Label("\(name) (\(unit))", systemImage: image)
			Spacer()
			Text(formattedAmount(amount: amount, unit: unit))
				.opacity(0.5)
		}
    }
	
	func formattedAmount(amount: Double, unit: String) -> String {
		if amount == floor(amount) {
			return String(format: "%.0f \(unit)", amount)
		} else {
			return String(format: "%.1f \(unit)", amount)
		}
	}
}

#Preview {
	MacroView(name: "Calories", unit: "Cal", image: "flame", amount: 100.0)
}
