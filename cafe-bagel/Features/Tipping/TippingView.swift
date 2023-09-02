
import SwiftUI

struct TippingView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Tipping!")
        }
        .padding()
    }
}

struct TippingView_Previews: PreviewProvider {
    static var previews: some View {
		TippingView()
    }
}
