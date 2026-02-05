
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
					.textStyle(.subheader)
				Spacer()
				Text(menuItem.basePrice.displayValue)
			}
		}
		.padding()
        .border(.blue, width: 2)
	}
}
