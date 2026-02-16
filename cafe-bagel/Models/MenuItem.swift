
import Foundation

struct MenuItem: Identifiable {
	let id = UUID() // TODO: does it make sense for MenuItem (and OptionGroup and Option) to have an identity? Should these be immutable value types instead?
	let name: String
	let basePrice: Money
	var optionGroups: [OptionGroup] = defaultOptionGroups
    var note: String? = nil
}

extension MenuItem {
    static func newMenuItem(from menuItem: MenuItem) -> MenuItem {
        MenuItem(
            name: menuItem.name,
            basePrice: menuItem.basePrice,
            optionGroups: menuItem.optionGroups,
            note: menuItem.note
        )
    }
}

extension MenuItem {
    var totalPrice: Money {
        optionGroups.reduce(into: basePrice) { price, optionGroup in
            price = price.adding(optionGroup.selectedOption?.additionalCost ?? Money.zero)
        }
    }
}

extension MenuItem {
    static let defaultOptionGroups: [OptionGroup] = [
        OptionGroup(
            name: "Milk",
            options: [
                OptionGroup.Option(name: "2%", additionalCost: nil),
                OptionGroup.Option(name: "Oat", additionalCost: Money(amountCents: 200)),
            ]
        ),
        OptionGroup(
            name: "Iced",
            options: [
                OptionGroup.Option(name: "Yes", additionalCost: nil),
                OptionGroup.Option(name: "No", additionalCost: nil),
            ]
        ),
        OptionGroup(
            name: "Sweetened",
            options: [
                OptionGroup.Option(name: "Yes", additionalCost: nil),
                OptionGroup.Option(name: "No", additionalCost: nil),
            ]
        ),
    ]
}

extension MenuItem {
    struct OptionGroup: Identifiable {
        let id = UUID()
		let name: String
		let options: [Option]
        
        private var _selectedOption: Option? = nil
        /// Returns the first item in `options` if a selected option has not been set yet.
        var selectedOption: Option? {
            get {
                // If an option has been set, return it.
                guard let option = _selectedOption else {
                    // If an option isn't required, don't set a default value using the first option.
                    return options.first
                }
                return option
            }
            set {
                _selectedOption = newValue
            }
        }

        init(name: String, options: [Option]) {
            self.name = name
            self.options = options
        }
        
        struct Option: Identifiable {
            let id = UUID()
			let name: String
			let additionalCost: Money?
		}
	}
}

extension MenuItem: Equatable, Hashable {}

extension MenuItem.OptionGroup: Equatable, Hashable {}

extension MenuItem.OptionGroup.Option: Equatable, Hashable {}
