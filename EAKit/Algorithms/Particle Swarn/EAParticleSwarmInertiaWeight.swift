//
//  EAParticleSwarmInertia.swift
//  EAKit
//
//  Created by Libor Polehna on 17/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EAParticleSwarmInertiaWeight {
    
    public static let defaultInertiaWeight = EAParticleSwarmInertiaWeight(start: 0.9, end: 0.4)
    
    public let start: Double
    public let end: Double
    
}
