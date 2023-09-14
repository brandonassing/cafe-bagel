
import Combine

class LocaleButtonViewModel: ObservableObject {
	@Published var locale: String = "English"

	init() {}
}
