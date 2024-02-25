
import SwiftUI

struct FillButtonView: View {
	private let text: String
	private let action: () -> Void
	
	init(text: String, action: @escaping () -> Void) {
		self.text = text
		self.action = action
	}
	
    var body: some View {
		Button {
			self.action()
		} label: {
			Text(self.text)
				.textStyle(.blockButtonSubtitle) // TODO: rethink textstyles and button styles
				.padding()
				.foregroundColor(.white)
				.background(StyleGuide.Colour.primary)
				.cornerRadius(StyleGuide.Size.buttonCornerRadius)
		}

	}
}

