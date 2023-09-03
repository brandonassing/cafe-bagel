
import Foundation

struct TippingOption: Identifiable {
	let id = UUID()
	let percentage: Int
	let moneyAmount: Money
	// TODO: maybe add property "type" that's enum with cases .percentage(Int), .none, .custom
	
	init(percentage: Int, preTipAmount: Money) {
		self.percentage = percentage
		
		let centsAmout = round((Float(self.percentage) / 100) * Float(preTipAmount.amountCents))
		self.moneyAmount = Money(amountCents: Int(centsAmout))
	}
}

extension TippingOption {
	var displayPercentage: String {
		"\(self.percentage)%"
	}
}
