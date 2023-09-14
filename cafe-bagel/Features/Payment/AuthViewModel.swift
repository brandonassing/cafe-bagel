
import Foundation
import Combine

class AuthViewModel: ObservableObject {
	@Published var isAuthorized: Bool = false
	@Published var isNoTip: Bool
	
	init(preTipAmount: Money, selectedTip: TippingOption) {
		self.isNoTip = (selectedTip.tipType == .noTip)
		
		// TODO: bug where this gets fired multiple times due to how SwiftUI calls init multiple times
		// TODO: use combine delay instead
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
			self?.isAuthorized = true
		}
	}
}
