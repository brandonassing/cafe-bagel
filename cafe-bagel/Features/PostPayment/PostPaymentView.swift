
import SwiftUI

struct PostPaymentView: View {
	@ObservedObject private var viewModel = PostPaymentViewModel()
	@Binding var navPath: [ViewType]

	var body: some View {
		VStack {
			HStack {
				Button {
					self.viewModel.newSaleTapped.send()
				} label: {
					Text("New sale")
						.foregroundColor(StyleGuide.TextStyle.inlineButton.color)
						.font(StyleGuide.TextStyle.inlineButton.font)
						.bold()
				}
				Spacer()
			}
			.frame(maxWidth: .infinity)

			Spacer()
			
			Text("Please come again!")
			
			Spacer()
			
			LocaleButtonView()
		}
		.padding()
		.navigationBarBackButtonHidden(true)
		.onReceive(self.viewModel.$postPaymentCompleted) {
			if $0 {
				self.navPath = []
			}
		}
	}
}
