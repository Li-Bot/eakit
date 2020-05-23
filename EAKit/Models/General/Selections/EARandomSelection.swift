//
//  EAGARandomSelection.swift
//  EAKit
//
//  Created by Libor Polehna on 17/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EARandomSelection<PopulationType: EAPopulationProtocol>: EASelectionProtocol {
    
    public let isElitism: Bool
    
    public init(isElitism: Bool = false) {
        self.isElitism = isElitism
    }
    
    public func createNewPopulation(population: PopulationType) -> PopulationType? {
        if let individual = population.bestIndividual, isElitism {
            return PopulationType(individuals: [individual])
        }
        return nil
    }
    
    public mutating func prepare(population: PopulationType, context: EAContextProtocol?) {
        
    }
    
    public func selectParents(population: PopulationType, count: Int, context: EAContextProtocol?) -> [PopulationType.IndividualType] {
        let distribution = EAUniformDistribution(range: 0 ... population.individuals.count - 1)
        
        let indexes = distribution.random(count: UInt(count))
        return indexes.map { index -> PopulationType.IndividualType in
            return population.individuals[index]
        }
    }
    
}
