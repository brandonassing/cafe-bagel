
import Foundation

struct TippingOption: Identifiable {
	let id = UUID()
	let tipType: TipType
	let moneyAmount: Money?
	
	init(_ tipType: TipType, preTipAmount: Money) {
		self.tipType = tipType
		
		switch tipType {
		case .noTip:
			self.moneyAmount = nil
		case .percentage(let percentage):
			let centsAmout = round((Float(percentage) / 100) * Float(preTipAmount.amountCents))
			self.moneyAmount = Money(amountCents: Int(centsAmout))
		}
	}
	
	enum TipType {
		case noTip
		case percentage(Int)
	}
}

extension TippingOption {
	var displayValue: String {
		switch self.tipType {
		case .noTip:
			return "No tip"
		case .percentage(let percentage):
			return "\(percentage)%"
		}
	}
}
