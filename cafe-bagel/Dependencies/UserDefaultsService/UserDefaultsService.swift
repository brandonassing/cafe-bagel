
import Foundation

protocol UserDefaultsServiceable {
	func getValue<T>(for key: UserDefaultsKey) -> T?
	func set<T>(value: T, for key: UserDefaultsKey)
}

class UserDefaultsService: UserDefaultsServiceable {
	private let defaults = UserDefaults.standard

	func getValue<T>(for key: UserDefaultsKey) -> T? {
		return defaults.value(forKey: key.rawValue) as? T
	}
	
	func set<T>(value: T, for key: UserDefaultsKey) {
		defaults.set(value, forKey: key.rawValue)
	}
}

enum UserDefaultsKey: String {
	case appMode
}
