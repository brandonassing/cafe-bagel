
protocol SettingsRepository {
	func getAppMode() -> AppMode?
	func setAppMode(to appMode: AppMode)
}

enum AppMode: String {
	case kiosk
	case kitchen
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

extension SettingsAppRepository {
	func getAppMode() -> AppMode? {
		let appModeString: String? = userDefaultsService.getValue(for: .appMode)
		guard let appModeString else { return nil }
		return AppMode(rawValue: appModeString)
	}
	
	func setAppMode(to appMode: AppMode) {
		userDefaultsService.set(value: appMode.rawValue, for: .appMode)
	}
}
