
import SwiftUI

struct AmountsHeaderView: View {
	private let preTipAmount: Money
	private let tipAmount: Money?
	private let totalAmount: Money
	
	init(preTipAmount: Money, tipAmount: Money?, totalAmount: Money) {
		self.preTipAmount = preTipAmount
		self.tipAmount = tipAmount
		self.totalAmount = totalAmount
	}
	
    var body: some View {
		VStack(spacing: 20) {
			Text(self.totalAmount.displayPets)
				.textStyle(StyleGuide.TextStyle.header, isBold: true)
			
			if let tipAmount = self.tipAmount {
				let amountsString = "\(self.preTipAmount.displayValue) + \(tipAmount.displayValue) tip"
				Text(amountsString)
					.textStyle(StyleGuide.TextStyle.details)
			}
		}
    }
}
