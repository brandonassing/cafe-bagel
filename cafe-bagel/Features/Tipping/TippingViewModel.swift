
import Combine

class TippingViewModel: ObservableObject {
	@Published var preTipAmount: Money = Money(amountCents: 669)
	@Published var tippingOptions: [TippingOption] = []
	@Published var locale: String = "English"
	
	init() {
		self.tippingOptions = [ // TODO: limit to 3 elements
			TippingOption(.percentage(15), preTipAmount: self.preTipAmount),
			TippingOption(.percentage(20), preTipAmount: self.preTipAmount),
			TippingOption(.percentage(25), preTipAmount: self.preTipAmount),
		]
	}
}
