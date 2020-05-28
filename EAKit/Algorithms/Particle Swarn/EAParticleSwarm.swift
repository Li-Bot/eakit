//
//  EAParticleSwarn.swift
//  EAKit
//
//  Created by Libor Polehna on 17/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EAParticleSwarm<FitnessFunctionType: EAFitnessFunctionProtocol>: EAAlgorithmProtocol where FitnessFunctionType.IndividualType == EAParticleSwarmPopulation.IndividualType {
    
    public let parameters: EAParticleSwarmParameters<FitnessFunctionType>
    
    private let uniformUnifiedDistribution = EAUniformDistribution(range: 0.0 ... 1.0)
    
    public init(parameters: EAParticleSwarmParameters<FitnessFunctionType>) {
        self.parameters = parameters
    }
    
    public func run() -> EAAlgorithmResult<EAParticleSwarmPopulation> {
        let context = EAParticleSwarmContext(velocity: parameters.velocity)
        var currentPopulation = PopulationType.getRandomPopulation(type: .uniform, fitnessFunction: parameters.fitnessFunction, size: parameters.populationCount, context: context)
        let result = EAAlgorithmResult(population: currentPopulation)
        
        for generationIndex in 0 ..< parameters.generationsCount - 1 {
            let population = PopulationType(individuals: [])
            for individual in currentPopulation.individuals {
                let velocity = computeVelocity(individual: individual, bestIndividual: result.bestPopulation.bestIndividual!, generationIndex: generationIndex)
                let newPosition = computePosition(velocity: velocity, position: individual.position)
                
                var newIndividual = individual.copy()
                newIndividual.position = newPosition
                //newIndividual.velocity = velocity
                newIndividual = parameters.fitnessFunction.validateDomains(individual: newIndividual)
                newIndividual.fitness = parameters.fitnessFunction.evaluate(individual: newIndividual)
                
                population.append(individual: newIndividual)
            }
            
            currentPopulation = population
            result.append(population: population, keepBestOnly: !parameters.output.saveProgress)
            parameters.delegate?.didFinishGeneration?(self, generationIndex, currentPopulation)
        }
        
        return result
    }
    
    @inline(__always)
    private func computePosition(velocity: [Double], position: [Double]) -> [Double] {
        var newPosition = [Double]()
        for index in 0 ..< position.count {
            newPosition.append(velocity[index] + position[index])
        }
        return newPosition
    }
    
    private func computeVelocity(individual: EAParticleSwarmPopulation.IndividualType, bestIndividual: EAParticleSwarmPopulation.IndividualType, generationIndex: UInt) -> [Double] {
        var velocityVector = [Double]()
        for index in 0 ..< parameters.fitnessFunction.dimension {
            let firstPart = computeInertiaWeight(generationIndex: generationIndex) * individual.velocity[index]
            let middlePart = parameters.learning.cP * uniformUnifiedDistribution.random() * (individual.bestPosition[index] - individual.position[index])
            let lastPart = parameters.learning.cG * uniformUnifiedDistribution.random() * (bestIndividual.bestPosition[index] - individual.position[index])
            var velocity = firstPart + middlePart + lastPart
            if velocity > parameters.velocity.maximum {
                velocity = parameters.velocity.maximum
            } else if velocity < parameters.velocity.maximum * -1.0 {
                velocity = parameters.velocity.maximum * -1.0
            }
            velocityVector.append(velocity)
        }
        return velocityVector
    }
    
    private func computeInertiaWeight(generationIndex: UInt) -> Double {
        let weight = parameters.inertiaWeight
        return weight.start - ((weight.start - weight.end) * Double(generationIndex)) / Double(parameters.generationsCount)
    }
    
}
