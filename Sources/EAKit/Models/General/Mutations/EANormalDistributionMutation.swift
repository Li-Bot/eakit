//
//  EANormalDistributionMutation.swift
//  EAKit
//
//  Created by Libor Polehna on 14/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Normal distribution mutation.
 */
public struct EANormalDistributionMutation<IndividualType: EAIndividualProtocol>: EAMutationProtocol where IndividualType.DataType == Double {
    
    public let threshold: Double
    /// Variance of distribution.
    public let σ: Double
    
    /**
     Create a new normal distribution mutation.
     
     - Parameter threshold: Treshold which defines if mutation will be performed or not. This parameter has to be in <0.0;1.0>.
     - Parameter σ: Variance of distribution.
     */
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
