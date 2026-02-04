
import Foundation

struct MenuItem: Identifiable {
	let id = UUID()
	let name: String
	let basePrice: Money
	var optionGroups: [OptionGroup] = defaultOptionGroups
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
            isRequired: true,
            options: [
                OptionGroup.Option(name: "2%", additionalCost: nil),
                OptionGroup.Option(name: "Oat", additionalCost: Money(amountCents: 200)),
            ]
        ),
        OptionGroup(
            name: "Iced",
            isRequired: true,
            options: [
                OptionGroup.Option(name: "Yes", additionalCost: nil),
                OptionGroup.Option(name: "No", additionalCost: nil),
            ]
        ),
        OptionGroup(
            name: "Sweetened",
            isRequired: true,
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
		let isRequired: Bool
		let options: [Option]
        
        private var _selectedOption: Option? = nil
        /// Returns the first item in `options` if `isRequired` is true and a selected option has not been set yet.
        var selectedOption: Option? {
            get {
                // If an option has been set, return it.
                guard let option = _selectedOption else {
                    // If an option isn't required, don't set a default value using the first option.
                    return isRequired ? options.first : nil
                }
                return option
            }
            set {
                _selectedOption = newValue
            }
        }

        init(name: String, isRequired: Bool, options: [Option]) {
            self.name = name
            self.isRequired = isRequired
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
