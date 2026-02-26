
import Combine
import CombineExt
import Foundation

class CartBuildingViewModel: ObservableObject {
	typealias Dependencies = HasMenuRepository
	
	let loadMenuItems: PassthroughSubject<Void, Never>
	let placeOrderTapped: PassthroughSubject<Void, Never>
	
	@Published var checkout: Checkout?
	@Published var menuItems: [MenuItem] = []
    @Published var order: Order = Order.new // Start with an empty `Order`.

	init(dependencies: Dependencies) {
		// MARK: Inputs
		self.loadMenuItems = PassthroughSubject<Void, Never>()
		self.placeOrderTapped = PassthroughSubject<Void, Never>()
		
		// MARK: Functionality
		self.placeOrderTapped
            .withLatestFrom(self.$order)
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
    
    func addItemToCart(_ menuItem: MenuItem) {
        self.order.menuItems.append(menuItem)
    }
    
    func setCustomer(_ customer: Customer) {
        self.order.customer = customer
    }
    
    func resetCart() {
        self.checkout = nil
        self.order = Order.new
    }
}
