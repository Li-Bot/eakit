//
//  EAESDiscreteRecombination.swift
//  EAKit
//
//  Created by Libor Polehna on 14/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Discrete Recombination.
 */
public struct EAESDiscreteRecombination<IndividualType: EAIndividualProtocol>: EAEvolutionaryStrategyRecombinationProtocol {
    
    /**
     Create a new discrete recombination.
     */
    public init() {
        
    }
    
    public func recombine(individuals: [IndividualType]) -> IndividualType {
        let uniformDistribution = EAUniformDistribution(range: 0 ... individuals.count - 1)
        var recombinant = IndividualType()
        for dataIndex in 0 ..< (individuals.first?.data.count ?? 0) {
            let randomIndex = uniformDistribution.random()
            let data = individuals[randomIndex].data[dataIndex]
            recombinant.data.append(data)
        }
        return recombinant
    }
    
}
