
import SwiftUI

struct TippingView: View {
	@StateObject private var viewModel: TippingViewModel = TippingViewModel()
	@State private var didSelectTip = false
	@State private var initialSelectedTip: TippingOption?

    var body: some View {
		
		VStack {
			Spacer()
				.frame(height: 120)
			
			Group {
				if let preTipAmount = self.viewModel.preTipAmount.displayPets {
					Text(preTipAmount)
						.textStyle(StyleGuide.TextStyle.header, isBold: true)
				}

				Spacer()
					.frame(height: 120)
				
				Text("Add a tip?")
					.textStyle(StyleGuide.TextStyle.subheader)
			}

			Spacer()
				.frame(height: 60)
			
			Grid(alignment: .center, horizontalSpacing: StyleGuide.Spacing.buttonMargin, verticalSpacing: StyleGuide.Spacing.buttonMargin) {
				GridRow {
					ForEach(self.viewModel.tippingOptions, id: \.id) { tippingOption in
						TippingOptionView(
							tippingOption: tippingOption,
							tapAction: { self.viewModel.selectTip.send($0) }
						)
					}
				}
				
				TippingOptionView(
					tippingOption: TippingOption(.noTip, preTipAmount: self.viewModel.preTipAmount),
					tapAction: { tippingOption in
						self.didSelectTip = true
						self.initialSelectedTip = tippingOption
					}
				)
				// TODO: move tip logic into vm and update to show messages for other options
				.alert(
					"Wow really?",
					isPresented: self.$didSelectTip,
					presenting: self.initialSelectedTip
				) { tippingOption in
					Button("Yes, I'm cheap") { self.viewModel.selectTip.send(tippingOption) }
					Button("You've convinced me") { }
				} message: { _ in Text("On Gladys' birthday?..") }
			}
			.frame(width: 1020)
			
			Spacer()
			
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
		.padding()
	}
}

struct TippingView_Previews: PreviewProvider {
    static var previews: some View {
		TippingView()
    }
}
