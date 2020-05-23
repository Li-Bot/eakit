//
//  EAEvolutionaryStrategyRecombinationProtocol.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 12/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public protocol EAEvolutionaryStrategyRecombinationProtocol {
    
    associatedtype IndividualType: EAIndividualProtocol
    
    func recombine(individuals: [IndividualType]) -> IndividualType
    
}
