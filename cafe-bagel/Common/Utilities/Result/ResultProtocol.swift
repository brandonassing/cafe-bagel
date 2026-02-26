
public protocol ResultProtocol {
	associatedtype Success
	associatedtype Failure: Error
	
	var success: Success? { get }
	var failure: Failure? { get }
}

extension Result: ResultProtocol {
	public var success: Success? {
		guard case .success(let value) = self else { return nil }
		return value
	}
	
	public var failure: Failure? {
		guard case .failure(let error) = self else { return nil }
		return error
	}
}
