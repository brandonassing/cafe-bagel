
import Combine

class TippingViewModel: ObservableObject {
	let selectTip: CurrentValueSubject<TippingOption?, Never>
	
	@Published var preTipAmount: Money = Money(amountCents: 669)
	@Published var tippingOptions: [TippingOption] = []
	@Published var locale: String = "English"
	@Published var selectedTip: TippingOption? = nil
	
	private var disposables = Set<AnyCancellable>()

	init() {
		
		self.selectTip = CurrentValueSubject<TippingOption?, Never>(TippingOption?.none)
		
		self.tippingOptions = [ // TODO: limit to 3 elements
			TippingOption(.percentage(15), preTipAmount: self.preTipAmount),
			TippingOption(.percentage(20), preTipAmount: self.preTipAmount),
			TippingOption(.percentage(25), preTipAmount: self.preTipAmount),
		]
		
		self.selectTip
			.sink { [weak self] tippingOption in
				self?.selectedTip = tippingOption
			}
			.store(in: &self.disposables)
	}
}
