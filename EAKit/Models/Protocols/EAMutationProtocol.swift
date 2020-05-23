//
//  EAGeneticAlgorithmMutationProtocol.swift
//  EAKit
//
//  Created by Libor Polehna on 15/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public protocol EAMutationProtocol {
    
    associatedtype IndividualType: EAIndividualProtocol
    
    var threshold: Double { get }
    
    mutating func prepare(context: EAContextProtocol?)
    func mutate(individual: IndividualType, context: EAContextProtocol?) -> IndividualType
    
}
