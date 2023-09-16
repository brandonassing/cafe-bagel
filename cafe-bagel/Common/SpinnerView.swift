
import SwiftUI

struct SpinnerView: View {
	@State private var isCircleRotating = true
	@State private var animateStart = false
	@State private var animateEnd = true

    var body: some View {
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
}

struct SpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerView()
    }
}
