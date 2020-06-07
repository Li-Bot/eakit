//
//  EAGeneticAlgorithmMutationProtocol.swift
//  EAKit
//
//  Created by Libor Polehna on 15/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Abstract mutation protocol.
 */
public protocol EAMutationProtocol {
    
    /// Generic Individual type.
    associatedtype IndividualType: EAIndividualProtocol
    
    /// Treshold which defines if mutation will be performed or not. This parameter has to be in <0.0;1.0>.
    var threshold: Double { get }
    
    /**
     This method is called before every generation. You can use it for preprocessing any data, which you will be needed for mutation later.
     
     - Parameter context: Additional metadata.
     */
    mutating func prepare(context: EAContextProtocol?)
    /**
     Mutate the `individual`.
     
     - Parameter individual: Individual to be mutated.
     - Parameter context: Additional metadata.
     
     - Returns: Mutated individual.
     */
    func mutate(individual: IndividualType, context: EAContextProtocol?) -> IndividualType
    
}
