//
//  EAGeneticAlgorithm.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 15/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EAGeneticAlgorithm<FitnessFunctionType: EAFitnessFunctionProtocol, SelectionType: EASelectionProtocol, CrossoverType: EAGeneticAlgorithmCrossoverProtocol, MutationType: EAMutationProtocol>: EAAlgorithmProtocol where FitnessFunctionType.IndividualType == CrossoverType.IndividualType, FitnessFunctionType.IndividualType == MutationType.IndividualType, SelectionType.PopulationType == EAPopulation<FitnessFunctionType.IndividualType> {
    
    public let parameters: EAGeneticAlgorithmParameters<FitnessFunctionType, SelectionType, CrossoverType, MutationType>
    
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
                let parents = parameters.selection.selectParents(population: currentPopulation, count: 2, context: nil)
                var offsprings: [PopulationType.IndividualType]
                let sizeDiff = Int(currentPopulation.size) - Int(population.size)
                
                if uniformUnifiedDistribution.random() <= parameters.crossover.threshold {
                    offsprings = parameters.crossover.cross(first: parents[0], second: parents[1])
                } else {
                    offsprings = parents
                }
                
                offsprings = Array(offsprings.prefix(upTo: min(max(sizeDiff, 0), offsprings.count)))
                for index in 0 ..< offsprings.count {
                    if uniformUnifiedDistribution.random() <= parameters.mutation.threshold {
                        offsprings[index] = parameters.mutation.mutate(individual: offsprings[index], context: nil)
                    }
                    offsprings[index] = parameters.fitnessFunction.validateDomains(individual: offsprings[index])
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
