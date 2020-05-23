//
//  EAParticleSwarmLearning.swift
//  EAKit
//
//  Created by Libor Polehna on 17/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EAParticleSwarmLearning {
    
    public static let defaultLearning = EAParticleSwarmLearning(cP: 0.2, cG: 0.2)
    
    public let cP: Double
    public let cG: Double
    
}
