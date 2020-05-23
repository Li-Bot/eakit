//
//  EANormalDistributionMutation.swift
//  EAKit
//
//  Created by Libor Polehna on 14/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EANormalDistributionMutation<IndividualType: EAIndividualProtocol>: EAMutationProtocol where IndividualType.DataType == Double {
    
    public let threshold: Double
    public let σ: Double
    
    public init(threshold: Double, σ: Double) {
        self.threshold = threshold
        self.σ = σ
    }
    
    public mutating func prepare(context: EAContextProtocol?) {
        
    }
    
    public func mutate(individual: IndividualType, context: EAContextProtocol?) -> IndividualType {
        var individual = individual
        
        for index in 0 ..< individual.data.count {
            let distribution = EANormalDistribution(μ: individual.data[index], σ: σ)
            individual.data[index] = distribution.random()
        }
        
        return individual
    }
    
}
