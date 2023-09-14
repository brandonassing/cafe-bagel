
import SwiftUI

enum StyleGuide {}

extension StyleGuide {
	enum Colour {
		static let primary = Color(red: 0.15, green: 0.43, blue: 0.96)
		static let dark = Color(red: 0.18, green: 0.18, blue: 0.18)
	}
}

extension StyleGuide.Colour {
	enum Text {
		static let light = Color.white
		static let dark = StyleGuide.Colour.dark
		static let inlineButton = StyleGuide.Colour.primary
	}
}

extension StyleGuide {
	enum TextStyle {
		case header
		case subheader
		case blockButtonTitle(size: Int)
		case blockButtonSubtitle
		case inlineButton
		case indicatorText
		
		var color: Color {
			switch self {
			case .header, .subheader, .indicatorText:
				return StyleGuide.Colour.Text.dark
			case .blockButtonTitle, .blockButtonSubtitle:
				return StyleGuide.Colour.Text.light
			case .inlineButton:
				return StyleGuide.Colour.Text.inlineButton
			}
		}
		
		var font: Font {
			switch self {
			case .header:
				return Font(CTFont(.menuTitle, size: 60))
			case .subheader:
				return Font(CTFont(.menuTitle, size: 50))
			case .blockButtonTitle(let size):
				return Font(CTFont(.controlContent, size: CGFloat(size)))
			case .blockButtonSubtitle:
				return Font(CTFont(.controlContent, size: 30))
			case .inlineButton:
				return Font(CTFont(.miniSystem, size: 25))
			case .indicatorText:
				return Font(CTFont(.message, size: 30))
			}
		}
	}
}

extension Text {
	func textStyle(_ textStyle: StyleGuide.TextStyle, isBold: Bool = false) -> Text {
		var view = self
			.foregroundColor(textStyle.color)
			.font(textStyle.font)
		
		if isBold {
			view = view.bold()
		}
		
		return view
	}
}

extension StyleGuide {
	enum Size {
		static let buttonMargin: CGFloat = 20
		static let checkoutIndicatorImage: CGFloat = 230
	}
}
