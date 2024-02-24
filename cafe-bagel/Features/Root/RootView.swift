
import SwiftUI

struct RootView: View {
	// TODO: consider refactoring app switcher to use `@SceneStorage` for retaining app state
	@StateObject private var rootViewModel = RootViewModel(dependencies: DependencyContainer.shared)
	
    var body: some View {
		if let appMode = rootViewModel.appMode {
			switch appMode {
			case .kiosk:
				CartBuildingView()
			case .kitchen:
				CartBuildingView() // TODO: update
			}
		} else {
			AppSwitcherView(viewModel: AppSwitcherViewModel(dependencies: DependencyContainer.shared))
		}
	}
}
