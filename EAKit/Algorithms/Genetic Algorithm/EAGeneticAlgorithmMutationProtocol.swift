//
//  EAGeneticAlgorithmMutationProtocol.swift
//  EAKit
//
//  Created by Libor Polehna on 15/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public protocol EAGeneticAlgorithmMutationProtocol {
    
    associatedtype IndividualType: EAIndividualProtocol
    
    var threshold: Double { get }
    
    func mutate(individual: IndividualType) -> IndividualType
    
}
