//
//  EAParticleSwarmIndividual.swift
//  EAKit
//
//  Created by Libor Polehna on 17/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Particle Swarm Individual.
 */
public final class EAParticleSwarmIndividual: EADoubleIndividual {
    
    /// Position of the particle.
    public var position: [DataType] {
        set {
            data = newValue
        }
        get {
            return data
        }
    }
    
    /// The best lifetime position of the particle.
    public private(set) var bestPosition: [DataType]
    /// Velocity of the particle.
    public var velocity: [DataType]
    
    /// Fitness value of the particle/individual.
    public override var fitness: Double {
        didSet {
            if fitness < oldValue {
                bestPosition = position
            }
        }
    }
    
    /**
     Create a new particle/individual.
     */
    public required init() {
        bestPosition = []
        velocity = []
        super.init()
    }
    
    /**
     Create a copy of the particle.
     
     - Returns: Copy of self.
     */
    public func copy() -> Self {
        let copy = Self()
        copy.position = position
        copy.velocity = velocity
        copy.fitness = fitness
        copy.bestPosition = bestPosition
        return copy
    }
    
}
