
import SwiftUI

struct SpinnerView: View {
	@State private var rotation: Angle = .degrees(0)
	@State private var trimStart: CGFloat = 1.0 / 9.0
	@State private var trimEnd: CGFloat = 2.0 / 5.0

    var body: some View {
		Circle()
			.trim(from: self.trimStart, to: self.trimEnd)
			.stroke(StyleGuide.Colour.dark, lineWidth: 6)
			.rotationEffect(self.rotation)
			.frame(width: StyleGuide.Size.checkoutIndicatorImage, height: StyleGuide.Size.checkoutIndicatorImage)
			.onAppear() {
				// Keep animations local to the spinner only
				withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
					self.rotation = .degrees(360)
				}
                // `trimStart` and `trimEnd` animates the arc length.
                // Eg: if we comment out the `trimStart` and `trimEnd` animation blocks and set `trimStart` to 0 and `trimEnd` to 0.5,
                // we'll see an arc that's half of the circle rotating with a fixed length.
				withAnimation(.linear(duration: 1).delay(0.5).repeatForever(autoreverses: true)) {
					self.trimStart = 1.0 / 3.0
				}
				withAnimation(.linear(duration: 1).delay(1).repeatForever(autoreverses: true)) {
					self.trimEnd = 1.0
				}
			}
    }
}

struct SpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerView()
    }
}
