
import Combine
import CombineExt

class TippingViewModel: ObservableObject {
	let tipTapped: CurrentValueSubject<TippingOption?, Never>
	let tipConfirmed: PassthroughSubject<Void, Never>
	
	@Published var checkout: Checkout
	@Published var preTipAmount: Money
	@Published var totalAmount: Money
	@Published var tippingOptions: [TippingOption]
	@Published var alert: Alert
	@Published var tipSelected: Bool
	
	private var disposables = Set<AnyCancellable>()

	init(checkout: Checkout) {
		// MARK: Inputs
		self.tipTapped = CurrentValueSubject<TippingOption?, Never>(TippingOption?.none)
		self.tipConfirmed = PassthroughSubject<Void, Never>()
		
		// MARK: Output defaults
		self.checkout = checkout
		self.preTipAmount = checkout.preTipAmount
		self.totalAmount = checkout.totalAmount
		self.tippingOptions = checkout.tippingOptions
		self.alert = .none
		self.tipSelected = false
		
		// MARK: Functionality
		self.tipTapped
			.sink { [weak self] tippingOption in
				guard let self, let tippingOption else { return }
				switch tippingOption.tipType {
				case .noTip:
					self.alert = .noTip
				case .percentage:
					guard let tipAmount = tippingOption.moneyAmount else {
						self.alert = .noTip
						return
					}
					guard
						let highestTipAmount = self.tippingOptions.last?.moneyAmount,
						tipAmount.amountCents < highestTipAmount.amountCents
					else {
						self.alert = .none
						self.tipConfirmed.send()
						return
					}
					self.alert = .notHighestTip
				}
			}
			.store(in: &self.disposables)
		
		self.tipConfirmed
			.withLatestFrom(self.tipTapped)
			.sink(receiveValue: { [weak self] tippingOption in
				guard let self else { return }
				self.checkout.selectedTip = tippingOption
				self.tipSelected = true
			})
			.store(in: &self.disposables)
	}
}

extension TippingViewModel {
	enum Alert {
		// represents no alert
		case none
		case noTip
		case notHighestTip
	}
}
