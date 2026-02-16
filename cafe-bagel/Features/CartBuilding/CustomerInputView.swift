import SwiftUI

struct CustomerInputView: View {
    private let onComplete: (Customer) -> Void
    @State private var customerName: String = ""
    @Environment(\.dismiss) private var dismiss
    
    init(onComplete: @escaping (Customer) -> Void) {
        self.onComplete = onComplete
    }
    
    var body: some View {
        VStack {
            Text("Please enter a name for the order")
                .textStyle(.detailsPrimary)
            TextField("Name", text: self.$customerName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Spacer()
                .frame(height: 30)
            
            FillButtonView(text: "Place order", isDisabled: self.customerName.isEmpty) {
                onComplete(Customer(nameString: self.customerName))
                dismiss()
            }
        }
        .padding()
    }
}
