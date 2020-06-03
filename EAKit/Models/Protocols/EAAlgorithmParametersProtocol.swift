//
//  EAAlgorithmParametersProtocol.swift
//  EAKit
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Error validation for common inputs of evolutionary algorithm.
 */
public enum EAAlgorithmParametersError: Error {
    
    /// Population size cannot be zero.
    case populationIsZero
    /// Number of generations cannot be zero.
    case generationsIsZero
    
}


/**
 Abstract evolutionary algorithm parameters.
 */
public protocol EAAlgorithmParametersProtocol {
    
    /// Generic Fitness Function type
    associatedtype FitnessFunctionType: EAFitnessFunctionProtocol
    
    /// Population size.
    var populationCount: UInt { get }
    /// Number of generations.
    var generationsCount: UInt { get }
    /// Problem to solve defined by Fitness Function.
    var fitnessFunction: FitnessFunctionType { get }
    
    /// Defined desired output data of an algorithm.
    var output: EAAlgorithmParametersOutput { get }
    
}
