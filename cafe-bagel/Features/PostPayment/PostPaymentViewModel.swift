
import Combine

class PostPaymentViewModel: ObservableObject {
	let newSaleTapped: PassthroughSubject<Void, Never>
	
	@Published var preTipAmount: Money
	@Published var tipAmount: Money?
	@Published var totalAmount: Money
	@Published var postPaymentCompleted: Bool
	
	init(checkout: Checkout) {
		// MARK: Inputs
		self.newSaleTapped = PassthroughSubject()
		
		// MARK: Output defaults
		self.preTipAmount = checkout.preTipAmount
		self.tipAmount = checkout.tipAmount
		// TODO: bug, sometimes totalAmount doesn't include tip amount. Maybe race condition?
		self.totalAmount = checkout.totalAmount
		self.postPaymentCompleted = false

		// MARK: Functionality
		self.newSaleTapped
			.map({ _ in true })
			.assign(to: &self.$postPaymentCompleted)
	}
}
