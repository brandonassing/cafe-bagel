
import Combine

class AppSwitcherViewModel: ObservableObject {
	// TODO: save app switcher choice to UserDefaults so when app is reloaded it goes directly to the choice
	let appSelected: PassthroughSubject<AppSwitcherChoice, Never>

	init() {
		let appSelected = PassthroughSubject<AppSwitcherChoice, Never>()
		self.appSelected = appSelected
	}
}

enum AppSwitcherChoice {
	case placeOrders
	case receiveOrders
}
