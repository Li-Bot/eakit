//
//  EAAlgorithmResult.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 General algorithm result with generic population type.
 */
public final class EAAlgorithmResult<PopulationType: EAPopulationProtocol>: EAAlgorithmResultProtocol {
    
    public var bestPopulation: PopulationType {
        return populations[bestPopulationIndex]
    }
    
    public private(set) var populations: [PopulationType]
    
    /// Index of the best population in the result.
    private var bestPopulationIndex: Int
    
    required public init(population: PopulationType) {
        populations = [population]
        bestPopulationIndex = 0
    }
    
    public func append(population: PopulationType, keepBestOnly: Bool) {
        if keepBestOnly {
            if let populationBestFitness = population.bestIndividual?.fitness, let bestPopulationFitness = bestPopulation.bestIndividual?.fitness, populationBestFitness < bestPopulationFitness {
                populations = [population]
                bestPopulationIndex = 0
            }
        } else {
            populations.append(population)
            if let populationBestFitness = population.bestIndividual?.fitness, let bestPopulationFitness = bestPopulation.bestIndividual?.fitness, populationBestFitness < bestPopulationFitness {
                bestPopulationIndex = populations.count - 1
            }
        }
    }
    
    public func set(population: PopulationType) {
        populations = [population]
        bestPopulationIndex = 0
    }
    
}
