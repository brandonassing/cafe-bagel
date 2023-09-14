
import Combine

class PostPaymentViewModel: ObservableObject {
	let newSaleTapped: PassthroughSubject<Void, Never>
	
	@Published var postPaymentCompleted: Bool = false
	
	init() {
		self.newSaleTapped = PassthroughSubject()
		
		self.newSaleTapped
			.map({ _ in true })
			.assign(to: &self.$postPaymentCompleted)
	}
}
