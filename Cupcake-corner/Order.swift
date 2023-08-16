//
//  Order.swift
//  Cupcake-corner
//
//  Created by Mathieu Dubart on 16/08/2023.
//

import SwiftUI

class Order: ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetName, city, zipcode
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnable = false {
        didSet {
            if !specialRequestEnable {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetName = ""
    @Published var city = ""
    @Published var zipcode = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetName.isEmpty || city.isEmpty || zipcode.isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        
        // $2 par cake
        var cost = Double(quantity) * 2
        
        // cake compliqué coûte plus cher
        cost += (Double(type) / 2)
        
        // $1 par cake pour extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.5 par cake pour des sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetName, forKey: .streetName)
        try container.encode(city, forKey: .city)
        try container.encode(zipcode, forKey: .zipcode)
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        streetName = try container.decode(String.self, forKey: .streetName)
        city = try container.decode(String.self, forKey: .city)
        zipcode = try container.decode(String.self, forKey: .zipcode)
    }
}
