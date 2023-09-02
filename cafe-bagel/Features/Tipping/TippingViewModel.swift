
import Combine

class TippingViewModel: ObservableObject {
	@Published var tippingOptions: [TippingOption] = []
	@Published var locale: String = "English"
	
	init() {
		self.tippingOptions = [ // TODO: limit to 3 elements
			TippingOption(percentage: 15),
			TippingOption(percentage: 20),
			TippingOption(percentage: 25)
		]
	}
}
