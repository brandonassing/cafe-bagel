
import Foundation

struct Customer {
	let id = UUID()
	let firstName: String
	let lastName: String
    
    init(nameString: String) {
        let nameComponents = nameString.split(separator: " ")
        self.firstName = String(nameComponents.first ?? "")
        self.lastName = String(nameComponents.dropFirst().joined(separator: " "))
    }
}

extension Customer {
	var fullName: String {
		"\(firstName) \(lastName)"
	}
}
