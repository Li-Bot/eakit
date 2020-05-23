//
//  EAGAFloatingNumericMutation.swift
//  EAKit
//
//  Created by Libor Polehna on 19/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EAFloatingNumericMutation<IndividualType: EAIndividualProtocol>: EAMutationProtocol where IndividualType.DataType == Double {
    
    public let threshold: Double
    public let count: UInt
    public let increment: Double
    
    public init(threshold: Double, count: UInt, increment: Double) {
        self.threshold = threshold
        self.count = count
        self.increment = increment
    }
    
    public mutating func prepare(context: EAContextProtocol?) {
        
    }
    
    public func mutate(individual: IndividualType, context: EAContextProtocol?) -> IndividualType {
        var individual = individual
        let distribution = EAUniformDistribution(range: 0 ... individual.data.count - 1)
        let indexes = distribution.random(count: count)
        
        for index in indexes {
            individual.data[index] += increment
        }
        
        return individual
    }
    
}
