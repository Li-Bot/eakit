//
//  EAGATournamentSelection.swift
//  EAKit
//
//  Created by Libor Polehna on 02/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
Tournament selection.
*/
public struct EATournamentSelection<PopulationType: EAPopulationProtocol>: EASelectionProtocol {
    
    /// If true, the best individual will be automatically added to the new population.
    public let isElitism: Bool
    /// Size of the tournament.
    public let size: UInt
    
    /**
     Create a new tournament selection.
     
     - Parameter isElitism: If true, the best individual will be automatically added to the new population.
     - Parameter tournamentSize: Size of the tournament.
     */
    public init(isElitism: Bool = false, tournamentSize: UInt) {
        self.isElitism = isElitism
        self.size = tournamentSize
    }
    
    public func createNewPopulation(population: PopulationType) -> PopulationType? {
        if let individual = population.bestIndividual, isElitism {
            return PopulationType(individuals: [individual])
        }
        return nil
    }
    
    public func prepare(population: PopulationType, context: EAContextProtocol?) {
        
    }
    
    public func selectParents(population: PopulationType, count: Int, context: EAContextProtocol?) -> [PopulationType.IndividualType] {
        var parents = [PopulationType.IndividualType]()
        let uniformDistribution = EAUniformDistribution(range: 0 ... Int(population.size) - 1)
        for _ in 0 ..< count {
            var bestIndividual: PopulationType.IndividualType?
            for _ in 0 ..< size {
                let randomIndividual = population.individuals[uniformDistribution.random()]
                if bestIndividual == nil || bestIndividual!.fitness > randomIndividual.fitness {
                    bestIndividual = randomIndividual
                }
            }
            parents.append(bestIndividual!)
        }
        
        return parents
    }
    
}
