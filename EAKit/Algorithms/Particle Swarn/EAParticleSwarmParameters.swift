//
//  EAParticleSwarmParameters.swift
//  EAKit
//
//  Created by Libor Polehna on 17/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EAParticleSwarmParameters<FitnessFunctionType: EAFitnessFunctionProtocol>: EAAlgorithmParameters<EAParticleSwarm<FitnessFunctionType>, EAParticleSwarmPopulation> where FitnessFunctionType.IndividualType == EAParticleSwarmPopulation.IndividualType {
    
    let velocity: EAParticleSwarmVelocity
    let learning: EAParticleSwarmLearning
    let inertiaWeight: EAParticleSwarmInertiaWeight

    public init(particlesCount: UInt, iterationsCount: UInt, velocity: EAParticleSwarmVelocity, learning: EAParticleSwarmLearning, inertiaWeight: EAParticleSwarmInertiaWeight, fitnessFunction: FitnessFunctionType, output: EAAlgorithmParametersOutput = .defaultOutput, delegate: EAAlgorithmDelegate<EAParticleSwarm<FitnessFunctionType>, EAParticleSwarmPopulation>? = nil) throws {
        self.velocity = velocity
        self.learning = learning
        self.inertiaWeight = inertiaWeight
        
        try super.init(populationCount: particlesCount, generationsCount: iterationsCount, fitnessFunction: fitnessFunction, output: output, delegate: delegate)
    }
    
}
