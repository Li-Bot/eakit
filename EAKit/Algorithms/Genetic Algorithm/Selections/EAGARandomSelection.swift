//
//  EAGARandomSelection.swift
//  EAKit
//
//  Created by Libor Polehna on 17/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EAGARandomSelection<PopulationType: EAPopulationProtocol>: EAGeneticAlgorithmSelectionProtocol {
    
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
    
    public func selectParents(population: PopulationType) -> EAParentsGroup<PopulationType.IndividualType> {
        let distribution = EAUniformDistribution(range: 0 ... population.individuals.count - 1)
        
        let indexes = distribution.random(count: 2)
        return EAParentsGroup(first: population.individuals[indexes[0]],
                              second: population.individuals[indexes[1]]
        )
    }
    
}
