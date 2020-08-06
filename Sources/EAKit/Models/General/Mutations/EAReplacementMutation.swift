//
//  EAGAReplacementMutation.swift
//  EAKit
//
//  Created by Libor Polehna on 04/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Replacement mutation. 
 */
public struct EAReplacementMutation<IndividualType: EAIndividualProtocol>: EAMutationProtocol {
    
    public let threshold: Double
    /// Number of replacements.
    public let count: UInt
    /// Valid values used for random replacement.
    public let set: [IndividualType.DataType]
    
    /**
     Create a new replacement mutation.
     
     - Parameter threshold: Treshold which defines if mutation will be performed or not. This parameter has to be in <0.0;1.0>.
     - Parameter count: Number of replacements.
     - Parameter set: Valid values used for random replacement.
     */
    public init(threshold: Double, count: UInt, set: [IndividualType.DataType]) {
        self.threshold = threshold
        self.count = count
        self.set = set
    }
    
    public mutating func prepare(context: EAContextProtocol?) {
        
    }
    
    public func mutate(individual: IndividualType, context: EAContextProtocol?) -> IndividualType {
        var individual = individual.copy()
        let randomPositionIndexes = EAUniformDistribution(range: 0 ... individual.data.count - 1).random(count: count)
        let randomDataIndexes = EAUniformDistribution(range: 0 ... set.count - 1).random(count: count)
        
        for index in 0 ..< Int(count) {
            individual.data[randomPositionIndexes[index]] = set[randomDataIndexes[index]]
        }
        
        return individual
    }
    
}
