
import Foundation

struct Money {
	let amountCents: Int
}

extension Money {
	var displayValue: String? {
		let dollars = self.amountCents / 100
		let remaindingCents = Float(self.amountCents % 100) / 100
		
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .currency

		return numberFormatter.string(for: Float(dollars) + remaindingCents)
	}
}
