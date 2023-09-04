
import SwiftUI

struct TippingOptionView: View {
	private let tippingOption: TippingOption
	
	init(tippingOption: TippingOption) {
		self.tippingOption = tippingOption
	}
	
	private var isPrimaryOption: Bool {
		switch self.tippingOption.tipType {
		case .noTip:
			return false
		case .percentage:
			return true
		}
	}
	
    var body: some View {
		Button {
			print(self.tippingOption.displayValue)
		} label: {
			VStack {
				Text(self.tippingOption.displayValue)
					.textStyle(StyleGuide.TextStyle.blockButtonTitle(size: self.isPrimaryOption ? 60 : 30))
				
				if let tipAmount = self.tippingOption.moneyAmount?.displayValue {
					Text(tipAmount)
						.textStyle(StyleGuide.TextStyle.blockButtonSubtitle)
				}
			}
			.padding()
			.frame(isPrimaryButton: self.isPrimaryOption)
			.foregroundColor(.white)
			.background(StyleGuide.Colour.primary)
		}
    }
}

fileprivate extension View {
	func frame(isPrimaryButton: Bool) -> some View {
		return isPrimaryButton ? self.frame(maxWidth: .infinity, maxHeight: 200) : self.frame(maxWidth: .infinity, minHeight: 100)
	}
}

struct TippingOptionView_Previews: PreviewProvider {
    static var previews: some View {
		TippingOptionView(tippingOption: TippingOption(.percentage(5), preTipAmount: Money(amountCents: 1000)))
    }
}
