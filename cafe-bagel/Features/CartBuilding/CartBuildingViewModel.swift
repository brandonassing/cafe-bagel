
import Combine
import CombineExt
import Foundation

class CartBuildingViewModel: ObservableObject {
	typealias Dependencies = HasMenuRepository
	
	let loadMenuItems: PassthroughSubject<Void, Never>
	let placeOrderTapped: PassthroughSubject<MenuItem, Never>
	
	@Published var checkout: Checkout? // TODO: how do we clear checkout after checkout completion? `CartBuildingViewModel` isn't re-init'd.
	@Published var menuItems: [MenuItem] = []
    // TODO: add a `savedMenuItems` to support multiple items per Order.

	init(dependencies: Dependencies) {
		// MARK: Inputs
		self.loadMenuItems = PassthroughSubject<Void, Never>()
		self.placeOrderTapped = PassthroughSubject<MenuItem, Never>()
		
		// MARK: Functionality
		self.placeOrderTapped
            .map { menuItem in
                Order(menuItem: menuItem, customer: nil, ticketId: "", note: "")
            }
            .map { order in Checkout(order: order) }
			.assign(to: &self.$checkout)
		
		let menuItemResults = self.loadMenuItems
			.flatMapLatest { _ in
				dependencies.menuRepository.getMenuItems()
			}
			.receive(on: DispatchQueue.main)
		
		menuItemResults
			.unwrapSuccess() // TODO: handle failure with error state
			.assign(to: &self.$menuItems)
	}
}
