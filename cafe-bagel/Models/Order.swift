
import Foundation

struct Order {
	let id = UUID()
	var menuItems: [MenuItem]
	let customer: Customer?
//	let ticketId: String
	let note: String?
	let date: Date = Date()
}

extension Order {
    var preTipAmount: Money {
        menuItems.reduce(into: Money.zero) { totalPrice, menuItem in
            totalPrice = totalPrice.adding(menuItem.totalPrice)
        }
    }
}

extension Order {
    static let new = Order(menuItems: [], customer: nil, note: nil)
}
