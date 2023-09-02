
import Foundation

struct TippingOption: Identifiable {
	let id = UUID()
	let percentage: Int
	// TODO: maybe add property "type" that's enum with cases .percentage(Int), .none, .custom
}

extension TippingOption {
	var displayPercentage: String {
		"\(self.percentage)%"
	}
}
