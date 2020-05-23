//
//  EAESNormalMutation.swift
//  EAKit
//
//  Created by Libor Polehna on 14/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EAESNormalMutation<IndividualType: EAIndividualProtocol>: EAMutationProtocol where IndividualType.DataType == Double {
    
    public let threshold: Double
    public private(set) var σ: Double
    public let cd: Double
    
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
