//
//  EADifferentialEvolutionMutationStrategy.swift
//  EAKit
//
//  Created by Libor Polehna on 24/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public protocol EADifferentialEvolutionMutationStrategyProtocol {
    
    associatedtype IndividualType: EAIndividualProtocol where IndividualType.DataType: Numeric
    
    var f: IndividualType.DataType { get }
    var λ: IndividualType.DataType { get }
    var parentsCount: Int { get }
    
    func mutate(activeIndividual: IndividualType, bestIndividual: IndividualType, individuals: [IndividualType], context: EADifferentialEvolutionContext) -> IndividualType
    
}
