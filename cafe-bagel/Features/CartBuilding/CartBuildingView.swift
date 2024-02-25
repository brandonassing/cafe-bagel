
import SwiftUI

struct CartBuildingView: View {
	@StateObject private var viewModel = CartBuildingViewModel()
	@State private var navPath: [ViewType] = []
	@StateObject private var checkoutNavigation = CheckoutNavigation()

    var body: some View {
		ScrollView {
			FillButtonView(text: "Place order") {
				self.viewModel.randomizePreTipAmount.send()
			}
		}
		.padding()
		.onReceive(self.viewModel.$checkout) { checkout in
			self.checkoutNavigation.showCheckout = checkout != nil
		}
		.fullScreenCover(isPresented: self.$checkoutNavigation.showCheckout, onDismiss: {
			self.viewModel.checkout = nil
			// Prevents pop to TippingView animation before sheet is fully dismissed
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
				self.navPath = []
			}
		}) {
			if let checkout = self.viewModel.checkout {
				NavigationStack(path: self.$navPath) {
					TippingView(navPath: self.$navPath, checkout: checkout)
						.navigationDestination(for: ViewType.self) { viewType in
							viewType.view(for: self.$navPath)
						}
						.navigationBarHidden(true)
				}
				.environmentObject(self.checkoutNavigation)
			}
		}
    }
}

final class CheckoutNavigation: ObservableObject {
	@Published var showCheckout = false
}

enum ViewType: Hashable {
	case tipping(checkout: Checkout)
	case auth(checkout: Checkout)
	case postPayment(checkout: Checkout)
	
	var caseId: String {
		switch self {
		case .tipping:
			return "tipping"
		case .auth:
			return "auth"
		case .postPayment:
			return "postPayment"
		}
	}
	
	static func == (lhs: ViewType, rhs: ViewType) -> Bool {
		switch (lhs, rhs) {
		case (.tipping(let checkout1), .tipping(let checkout2)), (.auth(let checkout1), .auth(let checkout2)), (.postPayment(let checkout1), .postPayment(let checkout2)):
			return checkout1.id == checkout2.id
		default:
			return false
		}
	}
	
	func hash(into hasher: inout Hasher) {
		switch self {
		case .tipping(let checkout), .auth(let checkout), .postPayment(let checkout):
			hasher.combine(self.caseId)
			hasher.combine(checkout.id)
		}
	}

	// Idea from https://stackoverflow.com/questions/74373192/how-to-send-extra-data-using-navigationstack-with-swiftui
	@ViewBuilder func view(for path: Binding<[ViewType]>) -> some View{
		switch self {
		case .tipping(let checkout):
			TippingView(navPath: path, checkout: checkout)
		case .auth(let checkout):
			AuthView(navPath: path, checkout: checkout)
		case .postPayment(let checkout):
			PostPaymentView(navPath: path, checkout: checkout)
		}
	}
}
