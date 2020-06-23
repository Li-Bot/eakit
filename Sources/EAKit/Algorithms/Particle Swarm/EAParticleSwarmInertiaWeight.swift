//
//  EAParticleSwarmInertia.swift
//  EAKit
//
//  Created by Libor Polehna on 17/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Inertia Weight of Particle Swarm.
 */
public struct EAParticleSwarmInertiaWeight {
    
    /// Default Inertia Weight.
    public static let defaultInertiaWeight = EAParticleSwarmInertiaWeight(start: 0.9, end: 0.4)
    
    /// Start weight.
    public let start: Double
    /// End weight.
    public let end: Double
    
}
