
import SwiftUI

struct AppSwitcherView: View {
	private let viewModel: AppSwitcherViewModel
	
	init(viewModel: AppSwitcherViewModel) {
		self.viewModel = viewModel
	}
	
    var body: some View {
		VStack {
			Text("I will be used to...")
				.textStyle(.header)
			HStack(spacing: StyleGuide.Size.buttonMargin) {
				FillButtonView(text: "Place orders") {
					self.viewModel.appSelected.send(.placeOrders)
				}
				FillButtonView(text: "Receive orders") {
					self.viewModel.appSelected.send(.receiveOrders)
				}
			}
		}
	}
}
