
import SwiftUI

struct TippingOptionView: View {
	private let tippingOption: TippingOption
	
	init(tippingOption: TippingOption) {
		self.tippingOption = tippingOption
	}
	
    var body: some View {
		Button {
			print(tippingOption.displayPercentage)
		} label: {
			Text(tippingOption.displayPercentage)
				.padding()
				.frame(width: 300, height: 200)
				.foregroundColor(.white)
				.background(StyleGuide.Colour.primary)
		}
    }
}

struct TippingOptionView_Previews: PreviewProvider {
    static var previews: some View {
        TippingOptionView(tippingOption: TippingOption(percentage: 5))
    }
}
