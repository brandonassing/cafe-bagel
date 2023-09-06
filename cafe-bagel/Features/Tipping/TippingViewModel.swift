
import Combine
import CombineExt

class TippingViewModel: ObservableObject {
	let tipTapped: CurrentValueSubject<TippingOption?, Never>
	let tipConfirmed: PassthroughSubject<Void, Never>
	
	@Published var preTipAmount: Money = Money(amountCents: 669)
	@Published var tippingOptions: [TippingOption] = []
	@Published var locale: String = "English"
	@Published var alert: Alert = .none
	@Published var selectedTip: TippingOption? = nil
	
	private var disposables = Set<AnyCancellable>()

	init() {
		
		self.tipTapped = CurrentValueSubject<TippingOption?, Never>(TippingOption?.none)
		self.tipConfirmed = PassthroughSubject<Void, Never>()
		
		let tippingOptions = [
				TippingOption(.percentage(15), preTipAmount: self.preTipAmount),
				TippingOption(.percentage(20), preTipAmount: self.preTipAmount),
				TippingOption(.percentage(25), preTipAmount: self.preTipAmount),
				TippingOption(.percentage(30), preTipAmount: self.preTipAmount),
			]
			.prefix(3)
		self.tippingOptions = Array(tippingOptions)
		
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
			.assign(to: &self.$selectedTip)
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
