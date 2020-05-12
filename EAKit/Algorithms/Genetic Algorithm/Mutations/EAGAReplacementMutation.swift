//
//  EAGAReplacementMutation.swift
//  EAKit
//
//  Created by Libor Polehna on 04/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EAGAReplacementMutation<IndividualType: EAIndividualProtocol>: EAGeneticAlgorithmMutationProtocol {
    
    public let threshold: Double
    public let count: UInt
    public let set: [IndividualType.DataType]
    
    public init(threshold: Double, count: UInt, set: [IndividualType.DataType]) {
        self.threshold = threshold
        self.count = count
        self.set = set
    }
    
    public func mutate(individual: IndividualType) -> IndividualType {
        var individual = individual
        let randomPositionIndexes = EAUniformDistribution(range: 0 ... individual.data.count - 1).random(count: count)
        let randomDataIndexes = EAUniformDistribution(range: 0 ... set.count - 1).random(count: count)
        
        for index in 0 ..< Int(count) {
            individual.data[randomPositionIndexes[index]] = set[randomDataIndexes[index]]
        }
        
        return individual
    }
    
}
