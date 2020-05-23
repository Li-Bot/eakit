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
    
    public func run() -> EAAlgorithmResult<EAPopulation<FitnessFunctionType.IndividualType>> {
        var currentIndividual = PopulationType.getRandomIndividual(type: .uniform, fitnessFunction: parameters.fitnessFunction, context: nil)
        let result = EAAlgorithmResult(population: PopulationType(individuals: [currentIndividual]))
        
        for iterationIndex in 0 ..< parameters.generationsCount - 1 {
            let population = PopulationType.getRandomPopulation(type: .normal(μ: currentIndividual.data, σ: parameters.deviation), fitnessFunction: parameters.fitnessFunction, size: parameters.populationCount, context: nil)
            
            result.append(population: population, keepBestOnly: !parameters.output.saveProgress)
            currentIndividual = population.bestIndividual!
            
            parameters.delegate?.didFinishGeneration?(self, iterationIndex, population)
        }
        
        return result
    }
    
}
