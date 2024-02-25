
import Combine

class CartBuildingViewModel: ObservableObject {
	let randomizePreTipAmount: PassthroughSubject<Void, Never>
	
	@Published var checkout: Checkout?

	init() {
		// MARK: Inputs
		self.randomizePreTipAmount = PassthroughSubject<Void, Never>()
		
		// MARK: Functionality
		self.randomizePreTipAmount
			.map { _ in Checkout(preTipAmount: Money.random()) }
			.assign(to: &self.$checkout)
	}
}
