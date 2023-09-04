
import SwiftUI

struct TippingView: View {
	@StateObject private var viewModel: TippingViewModel = TippingViewModel()

    var body: some View {
		
		VStack {
			Spacer()
				.frame(height: 120)
			
			Group {
				if let preTipAmount = self.viewModel.preTipAmount.displayValue {
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
					tapAction: { self.viewModel.selectTip.send($0) }
				)
			}
			.frame(width: 1020)
			
			Spacer()
			
			Button {
				print("Locale")
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
