
import Foundation

enum Sound {
	case shame
}

extension Sound {
	var url: URL {
		switch self {
		case .shame:
			return URL(string: "https://www.myinstants.com/media/sounds/shame-1.mp3")!
		}
	}
}
