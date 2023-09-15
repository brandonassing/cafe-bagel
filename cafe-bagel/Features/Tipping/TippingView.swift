
import SwiftUI

struct TippingView: View {
	@ObservedObject private var viewModel: TippingViewModel
	@State private var showAlert: Bool = false
	@Binding var navPath: [ViewType]

	init(navPath: Binding<[ViewType]>, checkout: Checkout) {
		self._navPath = navPath
		self.viewModel = TippingViewModel(checkout: checkout)
	}
	
    var body: some View {
		
		VStack {
			Spacer()
				.frame(height: 100)
			
			Group {
				AmountsHeaderView(
					preTipAmount: self.viewModel.preTipAmount,
					tipAmount: nil, // TODO: display dynamic tip amount for custom tip, and update header to display total
					totalAmount: self.viewModel.preTipAmount
				)

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
			.onReceive(self.viewModel.$tipSelected) { tipSelected in
				if tipSelected {
					self.navPath.append(.auth(checkout: self.viewModel.checkout))
				}
			}
			
			Spacer()
			
			LocaleButtonView()
		}
		.padding()
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
