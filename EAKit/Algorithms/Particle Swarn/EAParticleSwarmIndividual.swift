//
//  EAParticleSwarmIndividual.swift
//  EAKit
//
//  Created by Libor Polehna on 17/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EAParticleSwarmIndividual: EADoubleIndividual {
    
    public var position: [DataType] {
        set {
            data = newValue
        }
        get {
            return data
        }
    }
    
    public private(set) var bestPosition: [DataType]
    public var velocity: [DataType]
    
    public override var fitness: Double {
        didSet {
            if fitness < oldValue {
                bestPosition = position
            }
        }
    }
    
    public required init() {
        bestPosition = []
        velocity = []
        super.init()
    }
    
    public func copy() -> Self {
        let copy = Self()
        copy.position = position
        copy.velocity = velocity
        copy.fitness = fitness
        copy.bestPosition = bestPosition
        return copy
    }
    
}
