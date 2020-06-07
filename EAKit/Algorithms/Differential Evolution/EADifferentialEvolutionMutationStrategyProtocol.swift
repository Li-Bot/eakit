//
//  EADifferentialEvolutionMutationStrategy.swift
//  EAKit
//
//  Created by Libor Polehna on 24/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Abstract differential evolution mutation strategy protocol.
 */
public protocol EADifferentialEvolutionMutationStrategyProtocol {
    
    /// Generic Individual type.
    associatedtype IndividualType: EAIndividualProtocol where IndividualType.DataType: Numeric
    
    /// Mutation constant F.
    var f: IndividualType.DataType { get }
    /// Mutation constant λ.
    var λ: IndividualType.DataType { get }
    /// Number of parents.
    var parentsCount: Int { get }
    
    /**
     Mutate the individuals.
     
     - Parameter activeIndividual: Current individual.
     - Parameter bestIndividual: The best individual.
     - Parameter individuals: Parents.
     - Parameter context: Additional metadata.
     
     - Returns: Mutated individual.
     */
    func mutate(activeIndividual: IndividualType, bestIndividual: IndividualType, individuals: [IndividualType], context: EADifferentialEvolutionContext) -> IndividualType
    
}
