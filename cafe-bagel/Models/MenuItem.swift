
import Foundation

struct MenuItem: Identifiable {
	let id = UUID()
	let name: String
	let price: Money
	let optionGroups: [OptionGroup] = []
}

extension MenuItem {
	struct OptionGroup {
		let name: String
		let isRequired: Bool
		let isMultiSelection: Bool
		let options: [Option]
		let selectedOption: Option? // TODO: maybe set this to a default option.
		
		struct Option {
			let name: String
			let additionalCost: Money?
		}
	}
}
