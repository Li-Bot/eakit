//
//  HillClimbing.swift
//  EAKit
//
//  Created by Libor Polehna on 08/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EAHillClimbing<FitnessFunctionType: EAFitnessFunctionProtocol>: EAAlgorithmProtocol {
    
    public let parameters: EAHillClimbingParameters<FitnessFunctionType>
    
    public init(parameters: EAHillClimbingParameters<FitnessFunctionType>) {
        self.parameters = parameters
    }
    
    public func run() -> EAAlgorithmResult<FitnessFunctionType.PopulationType> {
        var currentIndividual = parameters.fitnessFunction.getRandomIndividual(type: .uniform)
        let result = EAAlgorithmResult(population: FitnessFunctionType.PopulationType(individuals: [currentIndividual]))
        
        for iterationIndex in 0 ..< parameters.generationsCount {
            let population = parameters.fitnessFunction.getRandomPopulation(type: .normal(μ: currentIndividual.data, σ: parameters.deviation), size: parameters.populationCount)
            
            result.append(population: population, keepBestOnly: !parameters.output.saveProgress)
            currentIndividual = population.bestIndividual!
            
            parameters.delegate?.didFinishGeneration?(self, iterationIndex, population)
        }
        
        return result
    }
    
}
