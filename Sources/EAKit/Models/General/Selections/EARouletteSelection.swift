//
//  EAGARouletteSelection.swift
//  EAKit
//
//  Created by Libor Polehna on 24/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Roulette selection.
 */
public struct EARouletteSelection<PopulationType: EAPopulationProtocol>: EASelectionProtocol {
    
    /// Tuple which consists of total and worst fitness value.
    private typealias FitnessTuple = (total: Double, worst: Double)
    
    /// If true, the best individual will be automatically added to the new population.
    public let isElitism: Bool
    
    /// Unified uniform distribution.
    private let unifiedUniformDistribution = EAUniformDistribution(range: 0.0 ... 1.0)
    
    /// Tuple which consists of total and worst fitness value.
    private var fitnessTuple: FitnessTuple = (0.0, 0.0)
    /// Probablities of individuals
    private var fitnessProbabilities: [Double] = []
    
    /**
    Create a new roulette selection.
    
    - Parameter isElitism: If true, the best individual will be automatically added to the new population.
    */
    public init(isElitism: Bool = false) {
        self.isElitism = isElitism
    }
    
    public func createNewPopulation(population: PopulationType) -> PopulationType? {
        if let individual = population.bestIndividual, isElitism {
            return PopulationType(individuals: [individual])
        }
        return nil
    }
    
    public mutating func prepare(population: PopulationType, context: EAContextProtocol?) {
        if population.bestIndividual == nil {
            fatalError("Population is empty")
        }
        
        fitnessTuple = sumFitness(of: population)
        fitnessProbabilities = [Double]()
        var probabilitiesSum = 0.0
        for individual in population.individuals {
            let probability = fitnessTuple.total == 0.0 ? 0.0 : ((fitnessTuple.worst - individual.fitness) + population.bestIndividual!.fitness) / fitnessTuple.total
            probabilitiesSum += probability
            fitnessProbabilities.append(probabilitiesSum)
        }
    }
    
    public func selectParents(population: PopulationType, count: Int, context: EAContextProtocol?) -> [PopulationType.IndividualType] {
        
        let randomNumbers = unifiedUniformDistribution.random(count: UInt(count)).sorted()
        if fitnessTuple.total == fitnessTuple.worst {
            return (0 ... count).map({ _ in population.individuals.randomElement()! })
        }
        
        var parents = [PopulationType.IndividualType]()
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
    
    /**
     Sum total fitness value of the `population` and find the worst fitness value in the `population`.
     
     - Parameter population: Population.
     
     - Returns: Total sum of fitness values and the worst fitness value.
     */
    @inline(__always)
    private func sumFitness(of population: PopulationType) -> FitnessTuple {
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
