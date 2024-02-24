
import Combine

class AppSwitcherViewModel: ObservableObject {
	typealias Dependencies = HasSettingsRepository
	
	private var settingsRepository: SettingsRepository
	
	let appSelected: PassthroughSubject<AppSwitcherChoice, Never>

	private var disposables = Set<AnyCancellable>()

	init(dependencies: Dependencies) {
		self.settingsRepository = dependencies.settingsRepository
		let appSelected = PassthroughSubject<AppSwitcherChoice, Never>()
		self.appSelected = appSelected
		
		appSelected
			.map { $0.appMode }
			.sink { [weak self] appMode in
				self?.settingsRepository.appMode = appMode
			}
			.store(in: &disposables)
	}
}

enum AppSwitcherChoice {
	case placeOrders
	case receiveOrders
	
	var appMode: AppMode {
		switch self {
		case .placeOrders:
			return .kiosk
		case .receiveOrders:
			return .kitchen
		}
	}
}
