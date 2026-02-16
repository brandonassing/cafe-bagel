
import SwiftUI

struct MenuItemView: View {
	private let menuItem: MenuItem
	
	init(_ menuItem: MenuItem) {
		self.menuItem = menuItem
	}
	
    var body: some View {
		VStack {
			HStack {
				Text(menuItem.name)
                    .textStyle(.detailsPrimary, isBold: true)
				Spacer()
				Text(menuItem.basePrice.displayValue)
                    .textStyle(.detailsSecondary)
			}
		}
		.padding()
        .background(StyleGuide.Colour.light)
        .cornerRadius(8)
	}
}
