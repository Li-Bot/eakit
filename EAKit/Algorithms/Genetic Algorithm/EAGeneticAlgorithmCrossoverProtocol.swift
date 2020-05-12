//
//  EAGeneticAlgorithmCrossoverProtocol.swift
//  EAKit
//
//  Created by Libor Polehna on 15/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public protocol EAGeneticAlgorithmCrossoverProtocol {
    
    associatedtype IndividualType: EAIndividualProtocol
    
    var threshold: Double { get }
    
    func cross(first: IndividualType, second: IndividualType) -> [IndividualType]
    
}
