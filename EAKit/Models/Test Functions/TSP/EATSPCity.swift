//
//  EATSPCity.swift
//  EAKit
//
//  Created by Libor Polehna on 20/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Information about a city.
 */
public struct EATSPCity {
    
    /// Id of a city.
    let id: String
    /// Coordinates of a city.
    let coordinates: [Double]
    
    /**
     Create a new city.
     
     - Parameter id: Id of the city.
     - Parameter coordinates: Coordinates of the city.
     */
    public init(_ id: String, _ coordinates: [Double]) {
        self.id = id
        self.coordinates = coordinates
    }
    
}


extension EATSPCity: CustomStringConvertible {
    
    public var description: String {
        var data = ""
        for coordinate in coordinates {
            data += "\(coordinate),"
        }
        data.removeLast()
        return data
    }
    
}
