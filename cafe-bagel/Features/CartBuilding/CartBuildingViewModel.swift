
import Combine
import CombineExt
import Foundation

class CartBuildingViewModel: ObservableObject {
	typealias Dependencies = HasMenuRepository
	
	let loadMenuItems: PassthroughSubject<Void, Never>
	let placeOrderTapped: PassthroughSubject<Void, Never>
	
	@Published var checkout: Checkout?
	@Published var menuItems: [MenuItem] = []

	init(dependencies: Dependencies) {
		// MARK: Inputs
		self.loadMenuItems = PassthroughSubject<Void, Never>()
		self.placeOrderTapped = PassthroughSubject<Void, Never>()
		
		// MARK: Functionality
		self.placeOrderTapped
			.map { _ in Checkout(preTipAmount: Money.random()) }
			.assign(to: &self.$checkout)
	}
}
