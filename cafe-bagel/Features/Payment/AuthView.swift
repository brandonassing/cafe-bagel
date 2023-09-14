
import SwiftUI

struct AuthView: View {
	@ObservedObject private var viewModel = AuthViewModel() // TODO: pass in auth amount
	@Binding var navPath: [ViewType]

    var body: some View {
		VStack {
			if self.viewModel.isAuthorized {
				Text("Authorized")
					.onAppear {
						DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
							self.navPath.append(.postPayment)
						}
					}
			} else {
				Text("Authorizing")
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.navigationBarBackButtonHidden(true)
    }
}
