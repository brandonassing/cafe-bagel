
import SwiftUI

struct LocaleButtonView: View {
	@ObservedObject private var viewModel = LocaleButtonViewModel()
	
    var body: some View {
		Button {
			// TODO: replace with SKStoreProductViewController to open app store in modal
			if let url = URL(string: "https://apps.apple.com/ca/app/duolingo-language-lessons/id570060128") {
				UIApplication.shared.open(url)
			}
		} label: {
			Label(self.viewModel.locale, systemImage: "globe")
				.foregroundColor(StyleGuide.TextStyle.inlineButton.color)
				.font(StyleGuide.TextStyle.inlineButton.font)
				.bold()
		}
    }
}
