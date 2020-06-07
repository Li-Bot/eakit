//
//  EAParticleSwarmLearning.swift
//  EAKit
//
//  Created by Libor Polehna on 17/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Learning constants of Particle Swarm.
 */
public struct EAParticleSwarmLearning {
    
    /// Default learning control parameters.
    public static let defaultLearning = EAParticleSwarmLearning(cP: 0.2, cG: 0.2)
    
    /// Learning constant of individual's best position.
    public let cP: Double
    /// Learning constant of the best individual's best position.
    public let cG: Double
    
}
