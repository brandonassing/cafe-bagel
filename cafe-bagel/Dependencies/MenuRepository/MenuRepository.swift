
import Combine

protocol MenuRepository {
	func getMenuItems() -> AnyPublisher<Result<[MenuItem], Error>, Never>
}

class MenuAppRepository: MenuRepository {
	
	init() {
		
	}
}

extension MenuAppRepository {
	func getMenuItems() -> AnyPublisher<Result<[MenuItem], Error>, Never> {
		// TODO: pull items from json file. Later create new app switcher entry "admin" for editing menu items. Eventually have menu items come from server
		// TODO: persist menu items to disk
		let menuItemsMock = [
			MenuItem(name: "Latte", price: Money(amountCents: 500)),
			MenuItem(name: "Americano", price: Money(amountCents: 450)),
			MenuItem(name: "Flat white", price: Money(amountCents: 475)),
		]
		return Just(.success(menuItemsMock))
			.eraseToAnyPublisher()
	}
}
