
protocol SettingsRepository {
	
}

class SettingsAppRepository: SettingsRepository {
	typealias Dependencies = HasSettingsNetworkService & HasUserDefaultsService
	
	private let settingsNetworkService: SettingsNetworkServiceable
	private let userDefaultsService: UserDefaultsServiceable
	
	init(dependencies: Dependencies) {
		self.settingsNetworkService = dependencies.settingsNetworkService
		self.userDefaultsService = dependencies.userDefaultsService
	}
}
