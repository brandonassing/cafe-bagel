
import Combine

extension Publisher where Output: ResultProtocol, Failure == Never {
	func unwrapSuccess() -> AnyPublisher<Output.Success, Never> {
		self
			.map { $0.success }
			.compactMap { $0 }
			.eraseToAnyPublisher()
	}
}
