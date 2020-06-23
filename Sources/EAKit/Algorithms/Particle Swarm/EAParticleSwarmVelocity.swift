//
//  EAParticleSwarmVelocity.swift
//  EAKit
//
//  Created by Libor Polehna on 17/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Velocity limits of a particle.
 */
public struct EAParticleSwarmVelocity {
    
    /// Maximum velocity.
    public let maximum: Double
    
    /**
     Create a new velocity.
     
     - Parameter maximum: Maximum velocity.
     */
    public init(maximum: Double) {
        self.maximum = maximum
    }
    
}
