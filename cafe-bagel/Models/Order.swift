
import Foundation

struct Order {
	let id = UUID()
	let menuItem: MenuItem // TODO: update to support multiple items
	let customer: Customer?
	let ticketId: String
	let note: String
	let date: Date = Date()
}

extension Order {
    var preTipAmount: Money {
        menuItem.price
    }
}
