
import Foundation
import Combine

class AuthViewModel: ObservableObject {
	@Published var isAuthorized: Bool = false
	@Published var isNoTip: Bool
	
	init(preTipAmount: Money, selectedTip: TippingOption) {
		self.isNoTip = (selectedTip.tipType == .noTip)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
			self?.isAuthorized = true
		}
	}
}
