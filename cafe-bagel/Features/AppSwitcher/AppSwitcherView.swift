
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
				// TODO: make reusable generic button
				Button {
					self.viewModel.appSelected.send(.placeOrders)
				} label: {
					Text("Place orders")
						.textStyle(.blockButtonSubtitle) // TODO: rethink textstyles and button styles
						.padding()
						.foregroundColor(.white)
						.background(StyleGuide.Colour.primary)
						.cornerRadius(StyleGuide.Size.buttonCornerRadius)
				}
				Button {
					self.viewModel.appSelected.send(.receiveOrders)
				} label: {
					Text("Receive orders")
						.textStyle(.blockButtonSubtitle)
						.padding()
						.foregroundColor(.white)
						.background(StyleGuide.Colour.primary)
						.cornerRadius(StyleGuide.Size.buttonCornerRadius)
				}
			}
		}
	}
}
