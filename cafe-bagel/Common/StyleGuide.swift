
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
		static let grey = Color(red: 0.25, green: 0.25, blue: 0.25)
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
		case details
		
		var color: Color {
			switch self {
			case .header, .subheader, .indicatorText:
				return StyleGuide.Colour.Text.dark
			case .blockButtonTitle, .blockButtonSubtitle:
				return StyleGuide.Colour.Text.light
			case .inlineButton:
				return StyleGuide.Colour.Text.inlineButton
			case .details:
				return StyleGuide.Colour.Text.grey
			}
		}
		
		var font: Font {
			switch self {
			case .header:
				return Font(CTFont(.menuTitle, size: 50))
			case .subheader:
				return Font(CTFont(.menuTitle, size: 40))
			case .blockButtonTitle(let size):
				return Font(CTFont(.controlContent, size: CGFloat(size)))
			case .blockButtonSubtitle:
				return Font(CTFont(.controlContent, size: 25))
			case .inlineButton:
				return Font(CTFont(.miniSystem, size: 20))
			case .indicatorText:
				return Font(CTFont(.message, size: 30))
			case .details:
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
		static let checkoutIndicatorImage: CGFloat = 160
		static let amountHeaderPadding: EdgeInsets = EdgeInsets(top: 80, leading: 0, bottom: 100, trailing: 0)
	}
}
