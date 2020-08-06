//
//  EAGAFloatingNumericMutation.swift
//  EAKit
//
//  Created by Libor Polehna on 19/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Numeric mutation.
 */
public struct EAFloatingNumericMutation<IndividualType: EAIndividualProtocol>: EAMutationProtocol where IndividualType.DataType == Double {
    
    public let threshold: Double
    /// Number of mutations.
    public let count: UInt
    /// Mutation value.
    public let increment: Double
    
    /**
     Create a new numeric mutation.
     
     - Parameter threshold: Treshold which defines if mutation will be performed or not. This parameter has to be in <0.0;1.0>.
     - Parameter count: Number of mutations.
     - Parameter increment: Mutation value.
     */
    public init(threshold: Double, count: UInt, increment: Double) {
        self.threshold = threshold
        self.count = count
        self.increment = increment
    }
    
    public mutating func prepare(context: EAContextProtocol?) {
        
    }
    
    public func mutate(individual: IndividualType, context: EAContextProtocol?) -> IndividualType {
        var individual = individual.copy()
        let distribution = EAUniformDistribution(range: 0 ... individual.data.count - 1)
        let indexes = distribution.random(count: count)
        
        for index in indexes {
            individual.data[index] += increment
        }
        
        return individual
    }
    
}
