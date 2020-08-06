//
//  EAIndividualProtocol.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Abstract individual protocol.
*/
public protocol EAIndividualProtocol {
    
    /// Generic Data type.
    associatedtype DataType
    
    /// Fitness value of individual.
    var fitness: Double { get set }
    /// Data which represents the individual.
    var data: [DataType] { get set }
    
    /**
     Create a new empty individual.
     */
    init()
    
    /**
     Create a copy of current instance.
     
     - Returns: A copy.
     */
    func copy() -> Self
    
}
