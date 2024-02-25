
import Foundation

struct MenuItem {
	let id = UUID()
	let name: String
	let description: String?
	let category: Category
	let price: Money
	let optionGroups: [OptionGroup]
}

extension MenuItem {
	enum Category {
		case drink
		case food
	}
	
	struct OptionGroup {
		let name: String
		let isRequired: Bool
		let isMultiSelection: Bool
		let options: [Option]
		let defaultOption: Option?
		let selectedOption: Option?
		
		struct Option {
			let name: String
			let additionalCost: Money?
		}
	}
}
