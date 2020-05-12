//
//  EAGASwapMutation.swift
//  EAKit
//
//  Created by Libor Polehna on 19/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EAGASwapMutation<IndividualType: EAIndividualProtocol>: EAGeneticAlgorithmMutationProtocol {
    
    public let threshold: Double
    public let count: UInt
    
    public init(threshold: Double, count: UInt) {
        self.threshold = threshold
        self.count = count
    }
    
    public func mutate(individual: IndividualType) -> IndividualType {
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
