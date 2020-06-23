//
//  EAParticleSwarn.swift
//  EAKit
//
//  Created by Libor Polehna on 17/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Particle Swarm Algorithm.
*/
public final class EAParticleSwarm<FitnessFunctionType: EAFitnessFunctionProtocol>: EAAlgorithmProtocol where FitnessFunctionType.IndividualType == EAParticleSwarmPopulation.IndividualType {
    
    /// Parameters of the algorithm.
    public let parameters: EAParticleSwarmParameters<FitnessFunctionType>
    
    /// Unified uniform distribution.
    private let uniformUnifiedDistribution = EAUniformDistribution(range: 0.0 ... 1.0)
    
    /**
     Create a new Particle Swarm Algorithm.
    
     - Parameter parameters: Parameters of the algorithm.
    */
    public init(parameters: EAParticleSwarmParameters<FitnessFunctionType>) {
        self.parameters = parameters
    }
    
    public func run() -> EAAlgorithmResult<EAParticleSwarmPopulation> {
        let context = EAParticleSwarmContext(velocity: parameters.velocity)
        var currentPopulation = PopulationType.getRandomPopulation(type: .uniform, fitnessFunction: parameters.fitnessFunction, size: parameters.populationCount, context: context)
        let result = EAAlgorithmResult(population: currentPopulation)
        
        for iterationIndex in 0 ..< parameters.generationsCount - 1 {
            let population = PopulationType(individuals: [])
            for individual in currentPopulation.individuals {
                // Compute new velocity.
                let velocity = computeVelocity(individual: individual, bestIndividual: result.bestPopulation.bestIndividual!, iterationIndex: iterationIndex)
                // Compute position of particle based on velocity.
                let newPosition = computePosition(velocity: velocity, position: individual.position)
                
                var newIndividual = individual.copy()
                newIndividual.position = newPosition
                //newIndividual.velocity = velocity
                // Validate particle.
                newIndividual = parameters.fitnessFunction.validateDomains(individual: newIndividual)
                // Evaluate particle.
                newIndividual.fitness = parameters.fitnessFunction.evaluate(individual: newIndividual)
                
                population.append(individual: newIndividual)
            }
            
            currentPopulation = population
            result.append(population: population, keepBestOnly: !parameters.output.saveProgress)
            parameters.delegate?.didFinishGeneration?(self, iterationIndex, currentPopulation)
        }
        
        return result
    }
    
    /**
     Compute new position based on velocity and current position.
     
     - Parameter velocity: Current velocity of particle.
     - Parameter position: Current position of particle.
     
     - Returns: New position of particle.
     */
    @inline(__always)
    private func computePosition(velocity: [Double], position: [Double]) -> [Double] {
        var newPosition = [Double]()
        for index in 0 ..< position.count {
            newPosition.append(velocity[index] + position[index])
        }
        return newPosition
    }
    
    /**
     Compute inertia weight based on current iteration.
     
     - Parameter iterationIndex: Current iteration.
     
     - Returns: Intertia.
     */
    @inline(__always)
    private func computeInertiaWeight(iterationIndex: UInt) -> Double {
        let weight = parameters.inertiaWeight
        return weight.start - ((weight.start - weight.end) * Double(iterationIndex)) / Double(parameters.generationsCount)
    }
    
    /**
     Compute velocity of a particle/`individual`.
     
     - Parameter individual: Current individual/particle.
     - Parameter bestIndividual: The best individual/particle.
     - Parameter generationIndex: Current iteration index.
     
     - Returns: Velocity.
     */
    private func computeVelocity(individual: EAParticleSwarmPopulation.IndividualType, bestIndividual: EAParticleSwarmPopulation.IndividualType, iterationIndex: UInt) -> [Double] {
        var velocityVector = [Double]()
        for index in 0 ..< parameters.fitnessFunction.dimension {
            let firstPart = computeInertiaWeight(iterationIndex: iterationIndex) * individual.velocity[index]
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
    
}
