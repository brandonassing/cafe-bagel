
import Combine

protocol SettingsRepository {
	var appMode: AppMode? { get set }
	var appModePublisher: Published<AppMode?>.Publisher { get }
}

enum AppMode: String {
	case kiosk
	case kitchen
}

class SettingsAppRepository: SettingsRepository {
	typealias Dependencies = HasSettingsNetworkService & HasUserDefaultsService
	
	private let settingsNetworkService: SettingsNetworkServiceable
	private let userDefaultsService: UserDefaultsServiceable
	
	@Published var appMode: AppMode? {
		willSet {
			guard newValue != getAppMode() else { return }
			userDefaultsService.set(value: newValue?.rawValue, for: .appMode)
		}
	}
	var appModePublisher: Published<AppMode?>.Publisher { $appMode }

	init(dependencies: Dependencies) {
		self.settingsNetworkService = dependencies.settingsNetworkService
		self.userDefaultsService = dependencies.userDefaultsService
		self.appMode = getAppMode()
	}
}

// MARK: private helpers
extension SettingsAppRepository {
	private func getAppMode() -> AppMode? {
		let appModeString: String? = userDefaultsService.getValue(for: .appMode)
		guard let appModeString else { return nil }
		return AppMode(rawValue: appModeString)
	}
}
