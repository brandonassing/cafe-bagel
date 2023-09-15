
import Foundation
import Combine

class AuthViewModel: ObservableObject {
	@Published var checkout: Checkout
	@Published var preTipAmount: Money
	@Published var tipAmount: Money?
	@Published var totalAmount: Money
	@Published var isNoTip: Bool
	@Published var isAuthorized: Bool

	init(checkout: Checkout) {
		// MARK: Output defaults
		self.checkout = checkout
		self.preTipAmount = checkout.preTipAmount
		self.tipAmount = checkout.tipAmount
		self.totalAmount = checkout.totalAmount
		self.isNoTip = checkout.hasNoTip
		self.isAuthorized = false
		
		// MARK: Functionality
		// TODO: use combine delay instead
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
			self?.isAuthorized = true
		}
	}
}
