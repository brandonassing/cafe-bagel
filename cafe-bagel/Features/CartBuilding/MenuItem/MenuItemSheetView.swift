
import SwiftUI

struct MenuItemSheetView: View {
    @State private var note: String = ""
    
    @State private var menuItem: MenuItem
	private let confirmAction: (MenuItem) -> Void

	init(_ menuItem: MenuItem, confirmAction: @escaping (MenuItem) -> Void) {
		self.menuItem = menuItem
		self.confirmAction = confirmAction
	}
	
    var body: some View {
        VStack {
            Text(self.menuItem.name)
                .textStyle(.header)
            Text(self.menuItem.totalPrice.displayValue)
                .textStyle(.details)
            
            VStack {
                ForEach(Array(self.menuItem.optionGroups.enumerated()), id: \.element.id) { index, optionGroup in
                    HStack {
                        Text(optionGroup.name)
                        Spacer()
                        Picker(optionGroup.name, selection: binding(for: index)) {
                            ForEach(optionGroup.options) { option in
                                self.optionDisplay(option)
                                    .tag(option.id)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
                
                TextField("Customize", text: $note)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
                        
            Spacer()
            FillButtonView(text: "Add to cart") {
                if !self.note.isEmpty {
                    self.menuItem.note = self.note
                }
                confirmAction(self.menuItem)
            }
        }
        .padding()
    }
    
    private func binding(for index: Int) -> Binding<MenuItem.OptionGroup.Option.ID?> {
        Binding(
            get: {
                self.menuItem.optionGroups[index].selectedOption?.id
            },
            set: { newValue in
                var updatedOptionGroups = self.menuItem.optionGroups

                if let newValue {
                    updatedOptionGroups[index].selectedOption = updatedOptionGroups[index].options.first { $0.id == newValue }
                } else {
                    updatedOptionGroups[index].selectedOption = nil
                }

                self.menuItem.optionGroups = updatedOptionGroups
            }
        )
    }
}

extension MenuItemSheetView {
    @ViewBuilder
    private func optionDisplay(_ option: MenuItem.OptionGroup.Option) -> some View {
        if let additionalCost = option.additionalCost {
            Text("\(option.name) - \(additionalCost.displayValue)")
        } else {
            Text(option.name)
        }
    }
}
