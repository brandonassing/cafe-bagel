
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
			}
        }
    }
}

enum ViewType: Hashable {
	case tipping
	case auth
	case postPayment
	
	// Idea from https://stackoverflow.com/questions/74373192/how-to-send-extra-data-using-navigationstack-with-swiftui
	@ViewBuilder func view(for path: Binding<[ViewType]>) -> some View{
		switch self{
		case .tipping:
			TippingView(navPath: path)
		case .auth:
			AuthView(navPath: path)
		case .postPayment:
			PostPaymentView(navPath: path)
		}
	}
}
