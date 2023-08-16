//
//  AddressView.swift
//  Cupcake-corner
//
//  Created by Mathieu Dubart on 16/08/2023.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Full name", text: $order.name)
                TextField("Street address", text: $order.streetName)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zipcode)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(!order.hasValidAddress)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        AddressView(order: Order())
    }
}
