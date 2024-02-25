
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
			MenuItem(name: "Latte", description: "It's a latte", category: .drink, price: Money(amountCents: 500), optionGroups: [])
		]
		return Just(.success(menuItemsMock))
			.eraseToAnyPublisher()
	}
}
