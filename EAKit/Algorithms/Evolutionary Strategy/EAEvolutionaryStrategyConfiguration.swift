//
//  EAEvolutionaryStrategyConfiguration.swift
//  EAKit
//
//  Created by Libor Polehna on 11/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EAEvolutionaryStrategyConfiguration {
    
    public let µ: UInt
    public let ρ: UInt
    public let selectionStrategy: EAEvolutionaryStrategySelectionStrategyType
    public let λ: UInt
    
    public init(µ: UInt, ρ: UInt, selectionStrategy: EAEvolutionaryStrategySelectionStrategyType, λ: UInt) throws {
        self.µ = µ
        self.ρ = ρ
        self.selectionStrategy = selectionStrategy
        self.λ = λ
    }
    
}
