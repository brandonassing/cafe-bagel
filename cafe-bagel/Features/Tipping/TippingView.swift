
import SwiftUI

struct TippingView: View {
	@StateObject private var viewModel: TippingViewModel = TippingViewModel()

    var body: some View {
		
		VStack {
			Spacer()
			
			Text("<TOTAL>")
			Text("Add a tip?")

			HStack(alignment: .center, spacing: 25) {
				ForEach(self.viewModel.tippingOptions, id: \.id) { tippingOption in
					TippingOptionView(tippingOption: tippingOption)
				}
			}
			
			Spacer()
			
			Button {
				print("Locale")
			} label: {
				Label(self.viewModel.locale, systemImage: "globe")
			}
		}
	}
}

struct TippingView_Previews: PreviewProvider {
    static var previews: some View {
		TippingView()
    }
}
