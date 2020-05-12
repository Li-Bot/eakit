//
//  EATSPCity.swift
//  EAKit
//
//  Created by Libor Polehna on 20/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EATSPCity {
    
    let id: String
    let coordinates: [Double]
    
    public init(_ id: String, _ coordinates: [Double]) {
        self.id = id
        self.coordinates = coordinates
    }
    
}
