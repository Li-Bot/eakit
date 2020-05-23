//
//  EAGARouletteSelection.swift
//  EAKit
//
//  Created by Libor Polehna on 24/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EARouletteSelection<PopulationType: EAPopulationProtocol>: EASelectionProtocol {
    
    private typealias FitnessTuple = (total: Double, worst: Double)
    
    public let isElitism: Bool
    
    private let unifiedUniformDistribution = EAUniformDistribution(range: 0.0 ... 1.0)
    
    private var fitnessTuple: FitnessTuple = (0.0, 0.0)
    private var fitnessProbabilities: [Double] = []
    
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
