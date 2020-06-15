//
//  EAESIntermadiateRecombination.swift
//  EAKit
//
//  Created by Libor Polehna on 14/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Intermadiate Recombination.
 */
public struct EAESIntermadiateRecombination<IndividualType: EADoubleIndividual>: EAEvolutionaryStrategyRecombinationProtocol {
    
    /**
     Create a new intermadiate recombination.
     */
    public init() {
        
    }
    
    public func recombine(individuals: [IndividualType]) -> IndividualType {
        let recombinant = IndividualType()
        for dataIndex in 0 ..< (individuals.first?.data.count ?? 0) {
            var sum: Double = 0.0
            for individual in individuals {
                sum += individual.data[dataIndex]
            }
            recombinant.data.append(sum / Double(individuals.count))
        }
        return recombinant
    }
    
}
