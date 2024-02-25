
import Foundation

// TODO: revisit this impl and make it more reactive
class Checkout: Identifiable {
	let id = UUID()
	
	let preTipAmount: Money
	var selectedTip: TippingOption? = nil
	var tipAmount: Money? {
		self.selectedTip?.moneyAmount
	}
	
	var totalAmount: Money {
		let totalAmountCents = preTipAmount.amountCents + (tipAmount?.amountCents ?? 0)
		return Money(amountCents: totalAmountCents)
	}
	
	var tippingOptions: [TippingOption]
	
	var hasNoTip: Bool {
		guard let selectedTip else { return true }
		guard let tipAmountCents = tipAmount?.amountCents else { return true}
		
		return selectedTip.tipType == .noTip || tipAmountCents == 0
	}
	
	init(preTipAmount: Money) {
		self.preTipAmount = preTipAmount
		self.tippingOptions = {
			let options = [
				TippingOption(.percentage(15), preTipAmount: preTipAmount),
				TippingOption(.percentage(20), preTipAmount: preTipAmount),
				TippingOption(.percentage(25), preTipAmount: preTipAmount),
				TippingOption(.percentage(30), preTipAmount: preTipAmount),
			]
			return Array(options.prefix(3))
		}()
	}
}
