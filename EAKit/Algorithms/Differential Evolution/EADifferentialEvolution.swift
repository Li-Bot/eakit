//
//  EADifferentialEvolution.swift
//  EAKit
//
//  Created by Libor Polehna on 24/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EADifferentialEvolution<FitnessFunctionType: EAFitnessFunctionProtocol, SelectionType: EASelectionProtocol, MutationStrategyType: EADifferentialEvolutionMutationStrategyProtocol, CrossoverType: EAGeneticAlgorithmCrossoverProtocol>: EAAlgorithmProtocol where EAPopulation<FitnessFunctionType.IndividualType> == SelectionType.PopulationType, FitnessFunctionType.IndividualType == MutationStrategyType.IndividualType, FitnessFunctionType.IndividualType == CrossoverType.IndividualType {
    
    public let parameters: EADifferentialEvolutionParameters<FitnessFunctionType, SelectionType, MutationStrategyType, CrossoverType>
    
    private let uniformUnifiedDistribution = EAUniformDistribution(range: 0.0 ... 1.0)
    
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
                let parents = parameters.selection.selectParents(population: currentPopulation, count: parameters.mutationStrategy.parentsCount, context: context)
                var offspring = parameters.mutationStrategy.mutate(activeIndividual: individual, bestIndividual: currentPopulation.bestIndividual!, individuals: parents, context: context)
                offspring = parameters.crossover.cross(first: individual, second: offspring).first!
                offspring = parameters.fitnessFunction.validateDomains(individual: offspring)
                offspring.fitness = parameters.fitnessFunction.evaluate(individual: offspring)
                
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
