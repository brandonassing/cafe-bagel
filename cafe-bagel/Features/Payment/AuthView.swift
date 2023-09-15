
import SwiftUI

struct AuthView: View {
	@StateObject private var viewModel: AuthViewModel
	@Binding var navPath: [ViewType]

	@State private var isCircleRotating = true
	@State private var animateStart = false
	@State private var animateEnd = true

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
			.animation(nil, value: UUID()) // Prevents AmountsHeaderView from (somehow) being affected by Circle animation

			// TODO: bug, entire VStack is animating downwards. Not happening on device though?
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
						
						Circle()
							.trim(
								from: self.animateStart ? 1/3 : 1/9,
								to: self.animateEnd ? 2/5 : 1
							)
							.stroke(StyleGuide.Colour.dark, lineWidth: 6)
							.rotationEffect(.degrees(self.isCircleRotating ? 360 : 0))
							.frame(width: StyleGuide.Size.checkoutIndicatorImage, height: StyleGuide.Size.checkoutIndicatorImage)
							.onAppear() {
								withAnimation(
									Animation
										.linear(duration: 1)
										.repeatForever(autoreverses: false)
								) {
									self.isCircleRotating.toggle()
								}
								withAnimation(
									Animation
										.linear(duration: 1)
										.delay(0.5)
										.repeatForever(autoreverses: true)
								) {
									self.animateStart.toggle()
								}
								withAnimation(
									Animation
										.linear(duration: 1)
										.delay(1)
										.repeatForever(autoreverses: true)
								) {
									self.animateEnd.toggle()
								}
							}
					}

					Text("Processing")
						.textStyle(.indicatorText, isBold: true)
				}
			}
			
			Spacer()
		}
		.padding()
		.navigationBarBackButtonHidden(true)
    }
}
