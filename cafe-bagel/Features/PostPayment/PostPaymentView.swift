
import SwiftUI

struct PostPaymentView: View {
	@StateObject private var viewModel: PostPaymentViewModel
	@Binding var navPath: [ViewType]

	init(navPath: Binding<[ViewType]>, checkout: Checkout) {
		self._navPath = navPath
		self._viewModel = StateObject(wrappedValue: PostPaymentViewModel(checkout: checkout))
	}

	var body: some View {
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
				AmountsHeaderView(
					preTipAmount: self.viewModel.preTipAmount,
					tipAmount: self.viewModel.tipAmount,
					totalAmount: self.viewModel.totalAmount
				)
				.padding(StyleGuide.Size.amountHeaderPadding)
				
				Image("LogoPostPayment")
					.resizable()
					.clipShape(Circle())
					.overlay(Circle().stroke(.white, lineWidth: 12))
					.overlay(Circle().stroke(StyleGuide.Colour.dark, lineWidth: 6))
					.frame(width: StyleGuide.Size.checkoutIndicatorImage, height: StyleGuide.Size.checkoutIndicatorImage)

				Spacer()
					.frame(height: 40)
				
				Text("Thanks!")
					.textStyle(.indicatorText, isBold: true)
				
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
