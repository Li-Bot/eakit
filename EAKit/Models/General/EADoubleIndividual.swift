//
//  EADoubleIndividual.swift
//  EAKit
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public typealias EADoubleIndividual = EAIndividual<Double>


/*extension EADoubleIndividual: CustomStringConvertible {
    
    public var description: String {
        let delimiter = ";"
        var result = ""
        for value in data {
            result += "\(value)\(delimiter)"
        }
        if result.hasSuffix(delimiter) {
            _ = result.removeLast()
        }
        return result
    }
    
}*/
