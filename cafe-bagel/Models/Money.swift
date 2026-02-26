
import Foundation

struct Money: Equatable, Hashable {
	let amountCents: Int
}

extension Money {
	var displayValue: String {
		let dollars = self.amountCents / 100
		let remaindingCents = Float(self.amountCents % 100) / 100
		
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .currency

		return numberFormatter.string(for: Float(dollars) + remaindingCents) ?? "\(self.amountCents) cents"
	}
	
	var displayPets: String {
		let dollars = self.amountCents / 100
		let remaindingCents = Float(self.amountCents % 100) / 100
		
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .decimal
		
		numberFormatter.maximumFractionDigits = 2
		numberFormatter.minimumFractionDigits = 2

		guard let formattedString = numberFormatter.string(for: Float(dollars) + remaindingCents) else {
			return "\(self.amountCents) pets in cents"
		}
		return "\(formattedString) pets"
	}
}

extension Money {
    func adding(_ moneyToAdd: Money) -> Money {
        Money(amountCents: self.amountCents + moneyToAdd.amountCents)
    }
}

extension Money {
    static let zero = Money(amountCents: 0)
    
	static func random() -> Money {
		let dollarAmount = Int.random(in: 2...8)
		let centsAddition = Bool.random() ? 50 : 0
		let centsAmount = (dollarAmount * 100) + centsAddition
		return Money(amountCents: centsAmount)
	}
}
