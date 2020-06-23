//
//  EAGASwapMutation.swift
//  EAKit
//
//  Created by Libor Polehna on 19/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Swap mutation.
 */
public struct EASwapMutation<IndividualType: EAIndividualProtocol>: EAMutationProtocol {
    
    public let threshold: Double
    /// Number of swappings.
    public let count: UInt
    
    /**
     Create a new swap mutation.
     
     - Parameter threshold: Treshold which defines if mutation will be performed or not. This parameter has to be in <0.0;1.0>.
     - Parameter count: Number of swappings.
     */
    public init(threshold: Double, count: UInt) {
        self.threshold = threshold
        self.count = count
    }
    
    public mutating func prepare(context: EAContextProtocol?) {
        
    }
    
    public func mutate(individual: IndividualType, context: EAContextProtocol?) -> IndividualType {
        var individual = individual
        let distribution = EAUniformDistribution(range: 0 ... individual.data.count - 1)
        
        for _ in 0 ..< count {
            let indexes = distribution.random(count: 2)
            
            let temp = individual.data[indexes[0]]
            individual.data[indexes[0]] = individual.data[indexes[1]]
            individual.data[indexes[1]] = temp
        }
        
        return individual
    }
    
}
