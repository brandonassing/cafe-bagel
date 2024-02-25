
import Foundation

struct Customer {
	let id = UUID()
	let firstName: String
	let lastName: String
}

extension Customer {
	var fullName: String {
		"\(firstName) \(lastName)"
	}
}
