
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
        // TODO: add a custom menu item so users can order something not added to the menu yet.
		let menuItemsMock = [
            MenuItem(name: "Latte", basePrice: Money(amountCents: 500)),
            MenuItem(name: "Matcha latte", basePrice: Money(amountCents: 450)),
			MenuItem(name: "Flat white", basePrice: Money(amountCents: 450)),
            MenuItem(name: "Americano", basePrice: Money(amountCents: 475), optionGroups: [
                MenuItem.OptionGroup(name: "Dairy", options: [
                    MenuItem.OptionGroup.Option(name: "None", additionalCost: nil),
                    MenuItem.OptionGroup.Option(name: "2%", additionalCost: nil),
                    MenuItem.OptionGroup.Option(name: "Cream", additionalCost: nil),
                    MenuItem.OptionGroup.Option(name: "Oat", additionalCost: Money(amountCents: 200)),
                ]),
                MenuItem.OptionGroup(
                    name: "Iced",
                    options: [
                        MenuItem.OptionGroup.Option(name: "Yes", additionalCost: nil),
                        MenuItem.OptionGroup.Option(name: "No", additionalCost: nil),
                    ]
                ),
                MenuItem.OptionGroup(
                    name: "Sweetened",
                    options: [
                        MenuItem.OptionGroup.Option(name: "Yes", additionalCost: nil),
                        MenuItem.OptionGroup.Option(name: "No", additionalCost: nil),
                    ]
                ),
            ]),
            MenuItem(name: "Cappuccino", basePrice: Money(amountCents: 475)),
            MenuItem(name: "Espresso", basePrice: Money(amountCents: 475), optionGroups: []),
		]
		return Just(.success(menuItemsMock))
			.eraseToAnyPublisher()
	}
}
