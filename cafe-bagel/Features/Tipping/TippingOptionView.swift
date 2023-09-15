
import SwiftUI

struct TippingOptionView: View {
	private let tippingOption: TippingOption
	private let tapAction: (TippingOption) -> Void
	
	private var isPrimaryOption: Bool {
		switch self.tippingOption.tipType {
		case .noTip:
			return false
		case .percentage:
			return true
		}
	}
	
	init(tippingOption: TippingOption, tapAction: @escaping (TippingOption) -> Void) {
		self.tippingOption = tippingOption
		self.tapAction = tapAction
	}
	
    var body: some View {
		Button {
			self.tapAction(self.tippingOption)
		} label: {
			VStack {
				Text(self.tippingOption.displayValue)
					.textStyle(StyleGuide.TextStyle.blockButtonTitle(size: self.isPrimaryOption ? 50 : 25))
				
				if let tipAmount = self.tippingOption.moneyAmount?.displayPets {
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
		return isPrimaryButton ? self.frame(maxWidth: .infinity, maxHeight: 180) : self.frame(maxWidth: .infinity, minHeight: 80)
	}
}
