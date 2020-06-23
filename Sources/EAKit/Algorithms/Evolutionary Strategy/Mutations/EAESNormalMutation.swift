//
//  EAESNormalMutation.swift
//  EAKit
//
//  Created by Libor Polehna on 14/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Normal Mutation based on Normal Distribution.
 */
public struct EAESNormalMutation<IndividualType: EAIndividualProtocol>: EAMutationProtocol where IndividualType.DataType == Double {
    
    public let threshold: Double
    /// Variance of distribution.
    public private(set) var σ: Double
    /// Control parameter.
    public let cd: Double
    
    /**
     Create a new normal mutation.
     
     - Parameter threshold: Treshold which defines if mutation will be performed or not. This parameter has to be in <0.0;1.0>.
     - Parameter σ: Variance of distribution.
     - Parameter cd: Control parameter.
     */
    public init(threshold: Double, σ: Double, cd: Double = 0.817) {
        self.threshold = threshold
        self.σ = σ
        self.cd = cd
    }
    
    public mutating func prepare(context: EAContextProtocol?) {
        guard let context = context as? EAEvolutionaryStrategyContext else {
            return
        }
        let rule = 1.0 / 5.0
        if context.betterRatio < rule {
            σ = cd * σ
        } else if context.betterRatio > rule {
            σ = σ / cd
        }
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
