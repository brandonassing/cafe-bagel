
import SwiftUI

struct FillButtonView: View {
	private let text: String
    private let isDisabled: Bool
	private let action: () -> Void
	
    init(text: String, isDisabled: Bool = false, action: @escaping () -> Void) {
		self.text = text
        self.isDisabled = isDisabled
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
                .background(isDisabled ? StyleGuide.Colour.primary.opacity(0.3) : StyleGuide.Colour.primary)
				.cornerRadius(StyleGuide.Size.buttonCornerRadius)
		}
        .disabled(isDisabled)
	}
}

