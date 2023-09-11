
import SwiftUI

@main
struct cafe_bagelApp: App {
    var body: some Scene {
        WindowGroup {
			NavigationStack { // TODO: move this into cart building view
				TippingView()
			}
        }
    }
}
