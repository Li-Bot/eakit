//
//  EAGATournamentSelection.swift
//  EAKit
//
//  Created by Libor Polehna on 02/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EAGATournamentSelection<PopulationType: EAPopulationProtocol>: EAGeneticAlgorithmSelectionProtocol {
    
    public let isElitism: Bool
    public let size: UInt
    public let k: Int
    
    public init(isElitism: Bool = false, tournamentSize: UInt) {
        self.isElitism = isElitism
        self.size = tournamentSize
        self.k = 2
    }
    
    public func createNewPopulation(population: PopulationType) -> PopulationType? {
        if let individual = population.bestIndividual, isElitism {
            return PopulationType(individuals: [individual])
        }
        return nil
    }
    
    public func selectParents(population: PopulationType) -> EAParentsGroup<PopulationType.IndividualType> {
        var parents = [PopulationType.IndividualType]()
        let uniformDistribution = EAUniformDistribution(range: 0 ... Int(population.size) - 1)
        for _ in 0 ..< k {
            var bestIndividual: PopulationType.IndividualType?
            for _ in 0 ..< size {
                let randomIndividual = population.individuals[uniformDistribution.random()]
                if bestIndividual == nil || bestIndividual!.fitness > randomIndividual.fitness {
                    bestIndividual = randomIndividual
                }
            }
            parents.append(bestIndividual!)
        }
        
        return EAParentsGroup(first: parents[0], second: parents[1])
    }
    
}
