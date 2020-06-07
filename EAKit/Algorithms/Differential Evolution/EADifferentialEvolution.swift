//
//  EADifferentialEvolution.swift
//  EAKit
//
//  Created by Libor Polehna on 24/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Differential Evolution Algorithm.
*/
public final class EADifferentialEvolution<FitnessFunctionType: EAFitnessFunctionProtocol, SelectionType: EASelectionProtocol, MutationStrategyType: EADifferentialEvolutionMutationStrategyProtocol, CrossoverType: EACrossoverProtocol>: EAAlgorithmProtocol where EAPopulation<FitnessFunctionType.IndividualType> == SelectionType.PopulationType, FitnessFunctionType.IndividualType == MutationStrategyType.IndividualType, FitnessFunctionType.IndividualType == CrossoverType.IndividualType {
    
    /// Parameters of the algorithm.
    public let parameters: EADifferentialEvolutionParameters<FitnessFunctionType, SelectionType, MutationStrategyType, CrossoverType>
    
    /// Unified uniform distribution.
    private let uniformUnifiedDistribution = EAUniformDistribution(range: 0.0 ... 1.0)
    
    /**
     Create a new Differential Evolution Algorithm.
    
     - Parameter parameters: Parameters of the algorithm.
    */
    public init(parameters: EADifferentialEvolutionParameters<FitnessFunctionType, SelectionType, MutationStrategyType, CrossoverType>) {
        self.parameters = parameters
    }
    
    public func run() -> EAAlgorithmResult<EAPopulation<FitnessFunctionType.IndividualType>> {
        let context = EADifferentialEvolutionContext()
        var currentPopulation = PopulationType.getRandomPopulation(type: .uniform, fitnessFunction: parameters.fitnessFunction, size: parameters.populationCount, context: context)
        let result = EAAlgorithmResult(population: currentPopulation)
        
        
        for generationIndex in 0 ..< parameters.generationsCount - 1 {
            let population = PopulationType(individuals: [])
            
            for individual in currentPopulation.individuals {
                // Select parents.
                let parents = parameters.selection.selectParents(population: currentPopulation, count: parameters.mutationStrategy.parentsCount, context: context)
                // Mutate current individual, bestIndividual and parents.
                var offspring = parameters.mutationStrategy.mutate(activeIndividual: individual, bestIndividual: currentPopulation.bestIndividual!, individuals: parents, context: context)
                // Crossover current individual and offspring.
                offspring = parameters.crossover.cross(first: individual, second: offspring).first!
                // Validate offspring.
                offspring = parameters.fitnessFunction.validateDomains(individual: offspring)
                // Evaluate offspring.
                offspring.fitness = parameters.fitnessFunction.evaluate(individual: offspring)
                
                // Add offspring to the next population if offspring is better than parent, otherwise add parent.
                if offspring.fitness < individual.fitness {
                    population.append(individual: offspring)
                } else {
                    population.append(individual: individual)
                }
            }
            
            currentPopulation = population
            result.append(population: population, keepBestOnly: !parameters.output.saveProgress)
            parameters.delegate?.didFinishGeneration?(self, generationIndex, currentPopulation)
        }
        
        return result
    }
    
}
