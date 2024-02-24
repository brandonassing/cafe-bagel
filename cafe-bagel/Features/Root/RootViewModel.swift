
import Combine

class RootViewModel: ObservableObject {
	typealias Dependencies = HasSettingsRepository
	
	@Published var appMode: AppMode?
	
	init(dependencies: Dependencies) {
		dependencies.settingsRepository.appModePublisher
			.assign(to: &$appMode)
	}
}
