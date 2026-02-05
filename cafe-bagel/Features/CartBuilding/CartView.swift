
import SwiftUI

// TODO: add validation; we need a customer to place order.
struct CartView: View {
    let order: Order
    let confirmAction: () -> Void
    
    var body: some View {
        VStack { // TODO: convert to scroll view
            ForEach(order.menuItems) { item in
                Text(item.name)
            }
            FillButtonView(text: "Place order") {
                confirmAction()
            }
        }
        .padding()
        .background(.gray)
    }
}
