//
//  EAEvolutionaryStrategyContext.swift
//  EAKit
//
//  Created by Libor Polehna on 14/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Context of additional metadata for Evolutionary Strategy algorithm.
 */
public struct EAEvolutionaryStrategyContext: EAContextProtocol {
    
    /// Ratio which says how many offsprings were better than their parents. Value is in <0.0;1.0>.
    var betterRatio: Double
    
}
