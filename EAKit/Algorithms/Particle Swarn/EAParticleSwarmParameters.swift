//
//  EAParticleSwarmParameters.swift
//  EAKit
//
//  Created by Libor Polehna on 17/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Parameters of Particle Swarm Algorithm.
*/
public final class EAParticleSwarmParameters<FitnessFunctionType: EAFitnessFunctionProtocol>: EAAlgorithmParameters<EAParticleSwarm<FitnessFunctionType>, EAParticleSwarmPopulation> where FitnessFunctionType.IndividualType == EAParticleSwarmPopulation.IndividualType {
    
    /// Velocity limits.
    let velocity: EAParticleSwarmVelocity
    /// Learning constants.
    let learning: EAParticleSwarmLearning
    /// Inertia Weight.
    let inertiaWeight: EAParticleSwarmInertiaWeight

    /**
     Create a new Particle Swarm parameters.
    
     - Parameter particlesCount: Number of particles. In other words number of individuals in the population.
     - Parameter iterationsCount: Number of iterations.
     - Parameter velocity: Velocity limits.
     - Parameter learning: Learning constants.
     - Parameter inertiaWeight: Inertia Weight.
     - Parameter fitnessFunction: Problem to be solved defined by fitness function.
     - Parameter output: Desired output data of an algorithm.
     - Parameter delegate: Delegate of the algorithm.
    */
    public init(particlesCount: UInt, iterationsCount: UInt, velocity: EAParticleSwarmVelocity, learning: EAParticleSwarmLearning, inertiaWeight: EAParticleSwarmInertiaWeight, fitnessFunction: FitnessFunctionType, output: EAAlgorithmParametersOutput = .defaultOutput, delegate: EAAlgorithmDelegate<EAParticleSwarm<FitnessFunctionType>, EAParticleSwarmPopulation>? = nil) throws {
        self.velocity = velocity
        self.learning = learning
        self.inertiaWeight = inertiaWeight
        
        try super.init(populationCount: particlesCount, generationsCount: iterationsCount, fitnessFunction: fitnessFunction, output: output, delegate: delegate)
    }
    
}
