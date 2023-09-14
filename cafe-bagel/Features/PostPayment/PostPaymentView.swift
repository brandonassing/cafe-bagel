
import SwiftUI

struct PostPaymentView: View {
	@ObservedObject private var viewModel: PostPaymentViewModel
	@Binding var navPath: [ViewType]

	init(navPath: Binding<[ViewType]>, checkout: Checkout) {
		self._navPath = navPath
		self.viewModel = PostPaymentViewModel(checkout: checkout)
	}

	var body: some View {
		// TODO: don't love the ZStack approach since things can technically overlay eachother
		ZStack {
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
			}
			
			VStack {
				Spacer()
					.frame(height: 120)

				Text(self.viewModel.totalAmount.displayPets)
					.textStyle(StyleGuide.TextStyle.header, isBold: true)
				
				Spacer()
			}

			VStack(alignment: .center, spacing: 40) {
				Image("LogoPostPayment")
					.resizable()
					.clipShape(Circle())
					.overlay(Circle().stroke(.white, lineWidth: 16))
					.overlay(Circle().stroke(StyleGuide.Colour.dark, lineWidth: 8))
					.frame(width: StyleGuide.Size.checkoutIndicatorImage, height: StyleGuide.Size.checkoutIndicatorImage)

				Text("Thanks!")
					.textStyle(.indicatorText, isBold: true)
			}
			
			VStack {
				Spacer()
				LocaleButtonView()
			}
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
