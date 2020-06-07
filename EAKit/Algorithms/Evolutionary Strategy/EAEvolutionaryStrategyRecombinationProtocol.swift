//
//  EAEvolutionaryStrategyRecombinationProtocol.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 12/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Abstract recombination protocol.
 */
public protocol EAEvolutionaryStrategyRecombinationProtocol {
    
    /// Generic Individual type.
    associatedtype IndividualType: EAIndividualProtocol
    
    /**
     Recombine the individuals.
     
     - Parameter individuals: Individuals to be recombined.
     
     - Returns: Recombined individual.
     */
    func recombine(individuals: [IndividualType]) -> IndividualType
    
}
