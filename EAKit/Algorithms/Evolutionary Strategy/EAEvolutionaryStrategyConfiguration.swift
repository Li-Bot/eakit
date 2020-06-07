//
//  EAEvolutionaryStrategyConfiguration.swift
//  EAKit
//
//  Created by Libor Polehna on 11/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Configuration of Evolutionary Strategy Algorithm.
 */
public struct EAEvolutionaryStrategyConfiguration {
    
    /// Number of individuals. In other words population size.
    public let µ: UInt
    /// Number of parents.
    public let ρ: UInt
    /// Individual Selection Strategy.
    public let selectionStrategy: EAEvolutionaryStrategySelectionStrategyType
    /// Number of offsprings.
    public let λ: UInt
    
    /**
     Create a new configuration of evolutionary strategy.
     
     - Parameter µ: Number of individuals. In other words population size.
     - Parameter ρ: Number of parents.
     - Parameter selectionStrategy: Individual Selection Strategy.
     - Parameter λ: Number of offsprings.
     */
    public init(µ: UInt, ρ: UInt, selectionStrategy: EAEvolutionaryStrategySelectionStrategyType, λ: UInt) throws {
        self.µ = µ
        self.ρ = ρ
        self.selectionStrategy = selectionStrategy
        self.λ = λ
    }
    
}
