//
//  EAIndividual.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 General individual with generic data type.
 */
public class EAIndividual<DataType>: EAIndividualProtocol {
    
    public var fitness: Double
    public var data: [DataType]
    
    public required init() {
        fitness = Double.greatestFiniteMagnitude
        data = []
    }
    
}
