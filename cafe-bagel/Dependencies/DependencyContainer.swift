
typealias AllDependencies = HasSettingsRepository & HasSettingsNetworkService & HasUserDefaultsService & HasMenuRepository

class DependencyContainer: AllDependencies {
	static let shared = DependencyContainer()
	private init() {}
	
	lazy var settingsRepository: SettingsRepository = {
		SettingsAppRepository(dependencies: self)
	}()
	
	lazy var settingsNetworkService: SettingsNetworkServiceable = {
		SettingsNetworkService()
	}()
	
	lazy var userDefaultsService: UserDefaultsServiceable = {
		UserDefaultsService()
	}()
	
	lazy var menuRepository: MenuRepository = {
		MenuAppRepository()
	}()
}

