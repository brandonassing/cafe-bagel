
import Combine

class AppSwitcherViewModel: ObservableObject {
	typealias Dependencies = HasSettingsRepository
	
	let appSelected: PassthroughSubject<AppSwitcherChoice, Never>

	private var disposables = Set<AnyCancellable>()

	init(dependencies: Dependencies) {
		let appSelected = PassthroughSubject<AppSwitcherChoice, Never>()
		self.appSelected = appSelected
		
		appSelected
			.sink { appSwitcherChoice in
				dependencies.settingsRepository.setAppMode(to: appSwitcherChoice.appMode)
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
