
import SwiftUI

struct CartBuildingView: View {
	@StateObject private var viewModel = CartBuildingViewModel(dependencies: DependencyContainer.shared)
	@State private var navPath: [ViewType] = []
	@StateObject private var checkoutNavigation = CheckoutNavigation()
    @State private var selectedMenuItem: MenuItem?

	private let columns = [
		GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
	]

    var body: some View {
		ScrollView(.vertical) {
			VStack {
				LazyVGrid(columns: self.columns) {
					ForEach(self.viewModel.menuItems, id: \.id) { menuItem in // TODO: id conflict if you add 2 of the same item.
						Button {
                            self.selectedMenuItem = menuItem
						} label: {
							MenuItemView(menuItem)
						}
                        .sheet(item: self.$selectedMenuItem) {
                            // Reset `selectedMenuItem` on dismiss
                            self.selectedMenuItem = nil
                        } content: { menuItem in
                            MenuItemSheetView(menuItem) { updatedMenuItem in
                                // Reset `selectedMenuItem` on completion.
                                self.selectedMenuItem = nil
                                self.viewModel.addItemToCart(updatedMenuItem)
                            }
                        }
					}
				}
                
                CartView(order: self.viewModel.order) {
                    self.viewModel.placeOrderTapped.send()
                }
			}
			.padding()
		}
		.onAppear { self.viewModel.loadMenuItems.send() }
		.onReceive(self.viewModel.$checkout) { checkout in
			self.checkoutNavigation.showCheckout = checkout != nil
		}
		.fullScreenCover(isPresented: self.$checkoutNavigation.showCheckout, onDismiss: {
			self.viewModel.resetCart()
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
