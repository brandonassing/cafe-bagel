
import SwiftUI

struct AuthView: View {
	@StateObject private var viewModel: AuthViewModel
	@Binding var navPath: [ViewType]

	init(navPath: Binding<[ViewType]>, checkout: Checkout) {
		self._navPath = navPath
		self._viewModel = StateObject(wrappedValue: AuthViewModel(checkout: checkout))
	}
	
    var body: some View {
		VStack {
			AmountsHeaderView(
				preTipAmount: self.viewModel.preTipAmount,
				tipAmount: self.viewModel.tipAmount,
				totalAmount: self.viewModel.totalAmount
			)
			.padding(StyleGuide.Size.amountHeaderPadding)

			VStack(alignment: .center, spacing: 40) {
				if self.viewModel.isAuthorized {
					Image("AuthCheckmark")
						.resizable()
						.overlay(Circle().stroke(StyleGuide.Colour.dark, lineWidth: 6))
						.frame(width: StyleGuide.Size.checkoutIndicatorImage, height: StyleGuide.Size.checkoutIndicatorImage)

					Text("Approved")
						.textStyle(.indicatorText, isBold: true)
						.onAppear {
							DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
								self.navPath.append(.postPayment(checkout: self.viewModel.checkout))
							}
						}
				} else {
					ZStack {
						if self.viewModel.isNoTip {
							Image("BagelSad")
								.resizable()
								.clipShape(Circle())
								.overlay(Circle().stroke(.white, lineWidth: 12))
								.frame(width: StyleGuide.Size.checkoutIndicatorImage, height: StyleGuide.Size.checkoutIndicatorImage)
						}
						SpinnerView()
					}

					Text("Processing")
						.textStyle(.indicatorText, isBold: true)
				}
			}
			
			Spacer()
		}
		.padding()
		.navigationBarBackButtonHidden(true)
		.animation(nil, value: UUID()) // Prevents view from being affected by SpinnerView animation

    }
}
