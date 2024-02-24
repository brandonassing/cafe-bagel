
import Combine

class RootViewModel: ObservableObject {
	typealias Dependencies = HasSettingsRepository
	
	@Published var appMode: AppMode?
	
	init(dependencies: Dependencies) {
		appMode = dependencies.settingsRepository.getAppMode()
	}
}
