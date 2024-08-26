//
//  CheckoutView.swift
//  SwiftUICupcake
//
//  Created by Kunal Kumar R on 22/08/24.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isShowingAlert = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(alertTitle, isPresented: $isShowingAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
        .scrollBounceBehavior(.basedOnSize)
    }
    
    //MARK: - Place order method
    func placeOrder() async {
        // Encode order
        guard let encodedOrder = try? JSONEncoder().encode(order) else {
            print("Failed to encode data")
            return
        }
        
        // URL Request
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encodedOrder)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            alertTitle = "Thank you!"
            alertMessage = "You order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            isShowingAlert = true
        }catch {
            alertTitle = "Error!"
            alertMessage = "\(error.localizedDescription)"
            isShowingAlert = true
        }
    }

}

#Preview {
    CheckoutView(order: Order())
}
