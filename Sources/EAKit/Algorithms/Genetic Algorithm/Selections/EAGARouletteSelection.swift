//
//  EAGARouletteSelection.swift
//  EAKit
//
//  Created by Libor Polehna on 24/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EARouletteSelection<PopulationType: EAPopulationProtocol>: EASelectionProtocol {
    
    public let isElitism: Bool
    
    public init(isElitism: Bool = false) {
        self.isElitism = isElitism
    }
    
    public func createNewPopulation(population: PopulationType) -> PopulationType? {
        if let individual = population.bestIndividual, isElitism {
            return PopulationType(individuals: [individual])
        }
        return nil
    }
    
    public func selectParents(population: PopulationType, count: Int) -> [PopulationType.IndividualType] {
        if population.bestIndividual == nil {
            fatalError("Population is empty")
        }
        
        var parents = [PopulationType.IndividualType]()
        let unifiedUniformDistribution = EAUniformDistribution(range: 0.0 ... 1.0)
        let (totalFitness, worstFitness) = sumFitness(of: population)
        let randomNumbers = unifiedUniformDistribution.random(count: UInt(count)).sorted()
        var fitnessProbabilities = [Double]()
        var probabilitiesSum = 0.0
        for individual in population.individuals {
            let probability = totalFitness == 0.0 ? 0.0 : ((worstFitness - individual.fitness) + population.bestIndividual!.fitness) / totalFitness
            probabilitiesSum += probability
            fitnessProbabilities.append(probabilitiesSum)
        }
        
        if totalFitness == worstFitness {
            return (0 ... count).map({ _ in population.individuals.randomElement()! })
        }
        
        var fitnessProbabilityIndex = 0
        for randomValue in randomNumbers {
            for probabilityIndex in fitnessProbabilityIndex ..< fitnessProbabilities.count {
                fitnessProbabilityIndex = probabilityIndex
                if fitnessProbabilities[probabilityIndex] > randomValue {
                    parents.append(population.individuals[probabilityIndex])
                    break
                }
            }
        }
        if parents.count == 1 {
            parents.append(population.individuals.last!)
        }
        
        return parents
    }
    
    @inline(__always)
    private func sumFitness(of population: PopulationType) -> (Double, Double) {
        var sum = 0.0
        var worstFitness = population.bestIndividual!.fitness
        for individual in population.individuals {
            if individual.fitness > worstFitness {
                worstFitness = individual.fitness
            }
        }
        for individual in population.individuals {
            sum += ((worstFitness - individual.fitness) + population.bestIndividual!.fitness)
        }
        return (sum, worstFitness)
    }
    
}
