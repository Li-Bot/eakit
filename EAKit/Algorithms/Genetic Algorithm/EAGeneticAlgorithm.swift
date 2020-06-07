//
//  EAGeneticAlgorithm.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 15/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Genetic Algorithm.
*/
public final class EAGeneticAlgorithm<FitnessFunctionType: EAFitnessFunctionProtocol, SelectionType: EASelectionProtocol, CrossoverType: EACrossoverProtocol, MutationType: EAMutationProtocol>: EAAlgorithmProtocol where FitnessFunctionType.IndividualType == CrossoverType.IndividualType, FitnessFunctionType.IndividualType == MutationType.IndividualType, SelectionType.PopulationType == EAPopulation<FitnessFunctionType.IndividualType> {
    
    /// Parameters of the algorithm.
    public let parameters: EAGeneticAlgorithmParameters<FitnessFunctionType, SelectionType, CrossoverType, MutationType>
    
    /**
     Create a new Genetic Algorithm.
    
     - Parameter parameters: Parameters of the algorithm.
    */
    public init(parameters: EAGeneticAlgorithmParameters<FitnessFunctionType, SelectionType, CrossoverType, MutationType>) {
        self.parameters = parameters
    }
    
    public func run() -> EAAlgorithmResult<SelectionType.PopulationType> {
        var currentPopulation = PopulationType.getRandomPopulation(type: .uniform, fitnessFunction: parameters.fitnessFunction, size: parameters.populationCount, context: nil)
        let result = EAAlgorithmResult(population: currentPopulation)
        let uniformUnifiedDistribution = EAUniformDistribution(range: 0.0 ... 1.0)
        
        for generationIndex in 0 ..< parameters.generationsCount - 1 {
            let population = parameters.selection.createNewPopulation(population: currentPopulation) ?? PopulationType(individuals: [])
            
            parameters.selection.prepare(population: currentPopulation, context: nil)
            parameters.mutation.prepare(context: nil)
            while population.size < currentPopulation.size {
                // Select parents.
                let parents = parameters.selection.selectParents(population: currentPopulation, count: 2, context: nil)
                var offsprings: [PopulationType.IndividualType]
                // Difference between new population size and desired population size.
                let sizeDiff = Int(currentPopulation.size) - Int(population.size)
                
                // Crossover parents and create offsprings.
                if uniformUnifiedDistribution.random() <= parameters.crossover.threshold {
                    offsprings = parameters.crossover.cross(first: parents[0], second: parents[1])
                } else {
                    offsprings = parents
                }
                
                // Assure that it will not exceed desired population size.
                offsprings = Array(offsprings.prefix(upTo: min(max(sizeDiff, 0), offsprings.count)))
                for index in 0 ..< offsprings.count {
                    // Mutate offspring.
                    if uniformUnifiedDistribution.random() <= parameters.mutation.threshold {
                        offsprings[index] = parameters.mutation.mutate(individual: offsprings[index], context: nil)
                    }
                    // Validate offspring.
                    offsprings[index] = parameters.fitnessFunction.validateDomains(individual: offsprings[index])
                    // Evaluate offspring.
                    offsprings[index].fitness = parameters.fitnessFunction.evaluate(individual: offsprings[index])
                    
                    // If elitism is enabled and parents is better than offspring then add parent to the new population.
                    if parameters.isElitism && parents[index].fitness < offsprings[index].fitness {
                        offsprings[index] = parents[index]
                    }
                }
                
                population.append(individuals: offsprings)
            }
            
            result.append(population: population, keepBestOnly: !parameters.output.saveProgress)
            currentPopulation = population
            
            parameters.delegate?.didFinishGeneration?(self, generationIndex, population)
        }
        
        return result
    }
    
}
