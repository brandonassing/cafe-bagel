
import SwiftUI

@main
struct cafe_bagelApp: App {
	var body: some Scene {
		WindowGroup {
			CartBuildingView()
				.preferredColorScheme(.light)
		}
	}
}
