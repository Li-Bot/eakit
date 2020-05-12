//
//  EAEvolutionaryStrategyConfiguration.swift
//  EAKit
//
//  Created by Libor Polehna on 11/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


struct EAEvolutionaryStrategyConfiguration {
    
    let µ: UInt
    let ρ: UInt
    let selectionStrategy: EAEvolutionaryStrategySelectionStrategyType
    let λ: UInt
    
    init(µ: UInt, ρ: UInt, selectionStrategy: EAEvolutionaryStrategySelectionStrategyType, λ: UInt) throws {
        self.µ = µ
        self.ρ = ρ
        self.selectionStrategy = selectionStrategy
        self.λ = λ
    }
    
}
