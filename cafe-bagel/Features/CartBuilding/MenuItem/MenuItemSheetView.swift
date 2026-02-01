
import SwiftUI

struct MenuItemSheetView: View {
    @StateObject private var viewModel: MenuItemSheetViewModel
	private let confirmAction: (MenuItem) -> Void

	init(_ menuItem: MenuItem, confirmAction: @escaping (MenuItem) -> Void) {
		self._viewModel = StateObject(wrappedValue: MenuItemSheetViewModel(menuItem))
		self.confirmAction = confirmAction
	}
	
    var body: some View {
        Text(self.viewModel.menuItem.name)
		FillButtonView(text: "Place order") {
            confirmAction(self.viewModel.menuItem)
		}
    }
}
