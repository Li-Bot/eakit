//
//  EAEvolutionaryStrategySelectionStrategyType.swift
//  EAKit
//
//  Created by Libor Polehna on 11/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Individual Selection Strategy of Evolutionary Strategy algorithm.
 */
public enum EAEvolutionaryStrategySelectionStrategyType {
    
    /// Individuals will be selected to the next population from offsprings + parents.
    case plus
    /// Individuals will be selected to the next population from offsprings only.
    case comma
    
}
