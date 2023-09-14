
import Foundation
import Combine

class AuthViewModel: ObservableObject {
	@Published var isAuthorized: Bool = false
	
	init() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
			self?.isAuthorized = true
		}
	}
}
