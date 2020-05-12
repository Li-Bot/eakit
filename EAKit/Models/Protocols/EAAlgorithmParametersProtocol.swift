//
//  EAAlgorithmParametersProtocol.swift
//  EAKit
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public enum EAAlgorithmParametersError: Error {
    
    case populationIsZero
    case generationsIsZero
    
}


public protocol EAAlgorithmParametersProtocol {
    
    associatedtype FitnessFunctionType: EAFitnessFunctionProtocol
    
    var populationCount: UInt { get }
    var generationsCount: UInt { get }
    var fitnessFunction: FitnessFunctionType { get }
    
    var output: EAAlgorithmParametersOutput { get }
    
}
