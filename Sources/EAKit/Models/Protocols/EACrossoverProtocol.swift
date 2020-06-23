//
//  EAGeneticAlgorithmCrossoverProtocol.swift
//  EAKit
//
//  Created by Libor Polehna on 15/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Abstract crossover protocol.
 */
public protocol EACrossoverProtocol {
    
    /// Generic Individual type.
    associatedtype IndividualType: EAIndividualProtocol
    
    /// Treshold which defines if crossover will be performed or not. This parameter has to be in <0.0;1.0>.
    var threshold: Double { get }
    
    /**
     Crossover the individuals.
     
     - Parameter first: First parent.
     - Parameter second: Second parent.
     
     - Returns: Offsprings of crossover of parents.
     */
    func cross(first: IndividualType, second: IndividualType) -> [IndividualType]
    
}
