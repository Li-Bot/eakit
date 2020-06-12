//
//  EAParticleSwarmContext.swift
//  EAKit
//
//  Created by Libor Polehna on 20/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Context of additional metadata for Particle Swarm algorithm.
 */
public struct EAParticleSwarmContext: EAContextProtocol {
    
    /// Velocity limits.
    public let velocity: EAParticleSwarmVelocity
    
}
