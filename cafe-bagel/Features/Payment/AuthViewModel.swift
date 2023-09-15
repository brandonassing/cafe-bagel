
import Foundation
import Combine
import AVFoundation

class AuthViewModel: ObservableObject {
	@Published var checkout: Checkout
	@Published var preTipAmount: Money
	@Published var tipAmount: Money?
	@Published var totalAmount: Money
	@Published var isNoTip: Bool
	@Published var isAuthorized: Bool

	private var audioPlayer: AVPlayer?

	init(checkout: Checkout) {
		// MARK: Output defaults
		self.checkout = checkout
		self.preTipAmount = checkout.preTipAmount
		self.tipAmount = checkout.tipAmount
		self.totalAmount = checkout.totalAmount
		self.isNoTip = checkout.hasNoTip
		self.isAuthorized = false
		
		if self.isNoTip {
			self.playSound(.shame)
		}
		
		// MARK: Functionality
		// TODO: use combine delay instead
		let authDelay = DispatchTimeInterval.seconds((self.isNoTip ? 9 : 3))
		DispatchQueue.main.asyncAfter(deadline: .now() + authDelay) { [weak self] in
			self?.isAuthorized = true
		}
	}
	
	func playSound(_ sound: Sound) {
		self.audioPlayer = AVPlayer(playerItem: AVPlayerItem(url: sound.url))
		self.audioPlayer!.volume = 1.0
		self.audioPlayer!.playImmediately(atRate: 1.0)
	}
}
