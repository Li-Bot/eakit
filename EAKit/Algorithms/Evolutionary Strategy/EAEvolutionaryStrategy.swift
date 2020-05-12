//
//  EAEvolutionaryStrategy.swift
//  EAKit
//
//  Created by Libor Polehna on 07/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EAEvolutionaryStrategy<FitnessFunctionType: EAFitnessFunctionProtocol, SelectionType: EAGeneticAlgorithmSelectionProtocol, CrossoverType: EAGeneticAlgorithmCrossoverProtocol, MutationType: EAGeneticAlgorithmMutationProtocol>: EAAlgorithmProtocol where FitnessFunctionType.PopulationType == SelectionType.PopulationType, FitnessFunctionType.PopulationType.IndividualType == CrossoverType.IndividualType, FitnessFunctionType.PopulationType.IndividualType == MutationType.IndividualType {
    
    public let parameters: EAGeneticAlgorithmParameters<FitnessFunctionType, SelectionType, CrossoverType, MutationType>
    
    public init(parameters: EAGeneticAlgorithmParameters<FitnessFunctionType, SelectionType, CrossoverType, MutationType>) {
        self.parameters = parameters
    }
    
    public func run() -> EAAlgorithmResult<FitnessFunctionType.PopulationType> {
        var currentPopulation = parameters.fitnessFunction.getRandomPopulation(type: .uniform, size: parameters.populationCount)
        let result = EAAlgorithmResult(population: currentPopulation)
        let uniformUnifiedDistribution = EAUniformDistribution(range: 0.0 ... 1.0)
        
        for generationIndex in 0 ..< parameters.generationsCount {
            let population = parameters.selection.createNewPopulation(population: currentPopulation) ?? FitnessFunctionType.PopulationType(individuals: [])
            
            while population.size < currentPopulation.size {
                let parents = parameters.selection.selectParents(population: currentPopulation)
                var offsprings: [FitnessFunctionType.PopulationType.IndividualType]
                let sizeDiff = Int(currentPopulation.size) - Int(population.size)
                
                if uniformUnifiedDistribution.random() <= parameters.crossover.threshold {
                    offsprings = parameters.crossover.cross(first: parents.first, second: parents.second)
                } else {
                    offsprings = [parents.first, parents.second]
                }
                
                offsprings = Array(offsprings.prefix(upTo: min(max(sizeDiff, 0), offsprings.count)))
                for index in 0 ..< offsprings.count {
                    if uniformUnifiedDistribution.random() <= parameters.mutation.threshold {
                        offsprings[index] = parameters.mutation.mutate(individual: offsprings[index])
                    }
                    offsprings[index].fitness = parameters.fitnessFunction.evaluate(individual: offsprings[index])
                    
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
