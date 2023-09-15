
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
		ZStack {
			VStack {
				Spacer()
					.frame(height: 100)
				
				AmountsHeaderView(
					preTipAmount: self.viewModel.preTipAmount,
					tipAmount: self.viewModel.tipAmount,
					totalAmount: self.viewModel.totalAmount
				)
				
				Spacer()
			}
			.animation(nil, value: UUID()) // Prevents AmountsHeaderView from (somehow) being affected by Circle animation

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
								from: animateStart ? 1/3 : 1/9,
								to: animateEnd ? 2/5 : 1
							)
							.stroke(lineWidth: 6)
							.rotationEffect(.degrees(isCircleRotating ? 360 : 0))
							.foregroundColor(StyleGuide.Colour.dark)
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
		}
		.padding()
		.navigationBarBackButtonHidden(true)
    }
}
