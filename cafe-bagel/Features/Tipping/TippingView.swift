
import SwiftUI

struct TippingView: View {
	@StateObject private var viewModel: TippingViewModel = TippingViewModel(preTipAmount: Money.random())
	@State private var showAlert: Bool = false
	@Binding var navPath: [ViewType]

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
			
			Grid(alignment: .center, horizontalSpacing: StyleGuide.Size.buttonMargin, verticalSpacing: StyleGuide.Size.buttonMargin) {
				GridRow {
					ForEach(self.viewModel.tippingOptions, id: \.id) { tippingOption in
						TippingOptionView(
							tippingOption: tippingOption,
							tapAction: { self.viewModel.tipTapped.send($0) }
						)
					}
				}
				
				TippingOptionView(
					tippingOption: TippingOption(.noTip, preTipAmount: self.viewModel.preTipAmount),
					tapAction: { self.viewModel.tipTapped.send($0) }
				)
			}
			.padding()
			.frame(width: 1020)
			.onReceive(self.viewModel.$alert) { self.showAlert = $0 != .none }
			.alert(
				self.viewModel.alert.title,
				isPresented: self.$showAlert,
				actions: {
					Button(self.viewModel.alert.confirmText) {
						self.viewModel.tipConfirmed.send()
					}
					Button(self.viewModel.alert.cancelText) {}
				},
				message: {
					Text(self.viewModel.alert.message)
				}
			)
			.onReceive(self.viewModel.$selectedTip) {
				if $0 != nil {
					self.navPath.append(.auth)
				}
			}
			
			Spacer()
			
			LocaleButtonView()
		}
		.padding()
		.onAppear { self.viewModel.randomizePreTipAmount.send() }
	}
}

extension TippingViewModel.Alert {
	var title: String {
		switch self {
		case .none:
			return "" // Shouldn't be showing an alert
		case .noTip:
			return "Wow, really?"
		case .notHighestTip:
			return "Hmm... 👀"
		}
	}
	
	var message: String {
		switch self {
		case .none:
			return "" // Shouldn't be showing an alert
		case .noTip:
			return "On Gladys' birthday?.."
		case .notHighestTip:
			return "Guess you don't think Gladys' birthday is *that* special, eh?"
		}
	}
	
	var confirmText: String {
		switch self {
		case .none:
			return "" // Shouldn't be showing an alert
		case .noTip:
			return "Yes, I'm cheap"
		case .notHighestTip:
			return "Sorry Gladys"
		}
	}

	var cancelText: String {
		switch self {
		case .none:
			return "" // Shouldn't be showing an alert
		case .noTip:
			return "I don't hate the hosts"
		case .notHighestTip:
			return "Today is a special day"
		}
	}
}
