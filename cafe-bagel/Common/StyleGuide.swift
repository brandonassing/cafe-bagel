
import SwiftUI

enum StyleGuide {}

extension StyleGuide {
	enum Colour {
		static let primary = Color(red: 0.15, green: 0.43, blue: 0.96)
	}
}

extension StyleGuide.Colour {
	enum Text {
		static let white = Color.white
		static let black = Color.black
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
		
		var color: Color {
			switch self {
			case .header:
				return StyleGuide.Colour.Text.black
			case .subheader:
				return StyleGuide.Colour.Text.black
			case .blockButtonTitle, .blockButtonSubtitle:
				return StyleGuide.Colour.Text.white
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
	enum Spacing {
		static let buttonMargin: CGFloat = 20
	}
}
