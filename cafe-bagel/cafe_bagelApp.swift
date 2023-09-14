
import SwiftUI

@main
struct cafe_bagelApp: App {
	@State private var navPath: [ViewType] = []

    var body: some Scene {
        WindowGroup {
			NavigationStack(path: self.$navPath) { // TODO: move this into cart building view and present checkout modally
				TippingView(navPath: self.$navPath)
					.navigationDestination(for: ViewType.self) { viewType in
						viewType.view(for: self.$navPath)
					}
					.navigationBarHidden(true)
			}
        }
    }
}

enum ViewType: Hashable {
	case tipping
	case auth(preTipAmount: Money, selectedTip: TippingOption)
	case postPayment
	
	static func == (lhs: ViewType, rhs: ViewType) -> Bool {
		switch (lhs, rhs) {
		case (.tipping, .tipping), (.postPayment, .postPayment):
			return true
		case (.auth(let preTipAmount1, let selectedTip1), .auth(let preTipAmount2, let selectedTip2)):
			return preTipAmount1 == preTipAmount2 && selectedTip1.id == selectedTip2.id
		default:
			return false
		}
	}
	
	func hash(into hasher: inout Hasher) {
		switch self {
		case .tipping:
			hasher.combine(1)
		case .auth(let preTipAmount, let selectedTip):
			hasher.combine(2)
			hasher.combine(preTipAmount.amountCents)
			hasher.combine(selectedTip.id)
		case .postPayment:
			hasher.combine(3)
		}
	}

	// Idea from https://stackoverflow.com/questions/74373192/how-to-send-extra-data-using-navigationstack-with-swiftui
	@ViewBuilder func view(for path: Binding<[ViewType]>) -> some View{
		switch self{
		case .tipping:
			TippingView(navPath: path)
		case .auth(let preTipAmount, let selectedTip):
			AuthView(navPath: path, preTipAmount: preTipAmount, selectedTip: selectedTip)
		case .postPayment:
			PostPaymentView(navPath: path)
		}
	}
}
