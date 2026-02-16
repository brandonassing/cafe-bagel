
import SwiftUI

struct CartView: View {
    let order: Order
    let confirmAction: () -> Void
    
    var body: some View {
        VStack {
            // TODO: support removing menu items from Order.
            ForEach(order.menuItems) { item in
                HStack {
                    Text(item.name)
                        .textStyle(.detailsPrimary, isBold: true, isItalic: true)
                    Spacer()
                    Text(item.basePrice.displayValue)
                        .textStyle(.detailsPrimary)
                }
                ForEach(item.optionGroups) { optionGroup in
                    if let selectedOption = optionGroup.selectedOption {
                        HStack {
                            Spacer()
                                .frame(width: 50)
                            Text("\(optionGroup.name) - \(selectedOption.name)")
                                .textStyle(.detailsSecondary)
                            Spacer()
                            if let additionalCost = selectedOption.additionalCost {
                                Text("+ \(additionalCost.displayValue)")
                                    .textStyle(.detailsSecondary)
                            }
                        }
                    }
                }
                if let note = item.note, !note.isEmpty {
                    Spacer()
                        .frame(height: 12)

                    HStack {
                        Spacer()
                            .frame(width: 50)
                        Text(note)
                            .textStyle(.detailsSecondary, isItalic: true)
                            .lineLimit(3)
                        Spacer()
                    }
                }

                Spacer()
                    .frame(height: 30)
            }
            
            HStack {
                Text("Total")
                    .textStyle(.detailsPrimary, isBold: true)
                Spacer()
                Text(order.preTipAmount.displayValue)
                    .textStyle(.detailsPrimary)
            }
            
            Spacer()
                .frame(height: 50)
            
            FillButtonView(text: "Continue", isDisabled: order.menuItems.isEmpty) {
                confirmAction()
            }
        }
        .padding()
        .frame(width: 600)
    }
}
