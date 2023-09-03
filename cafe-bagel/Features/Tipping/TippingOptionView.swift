
import SwiftUI

struct TippingOptionView: View {
	private let tippingOption: TippingOption
	
	init(tippingOption: TippingOption) {
		self.tippingOption = tippingOption
	}
	
    var body: some View {
		Button {
			print(self.tippingOption.displayPercentage)
		} label: {
			VStack {
				Text(self.tippingOption.displayPercentage)
					.textStyle(StyleGuide.TextStyle.blockButtonTitle(size: 60))
				
				if let tipAmount = self.tippingOption.moneyAmount.displayValue {
					Text(tipAmount)
						.textStyle(StyleGuide.TextStyle.blockButtonSubtitle)
				}
			}
			.padding()
			.frame(width: 320, height: 200)
			.foregroundColor(.white)
			.background(StyleGuide.Colour.primary)
		}
    }
}

struct TippingOptionView_Previews: PreviewProvider {
    static var previews: some View {
        TippingOptionView(tippingOption: TippingOption(percentage: 5, preTipAmount: Money(amountCents: 1000)))
    }
}
