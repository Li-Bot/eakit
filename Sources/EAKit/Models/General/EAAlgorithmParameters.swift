//
//  EAAlgorithmParameters.swift
//  EAKit
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 General algorithm parameters with generic algorithm type and population type.
 */
public class EAAlgorithmParameters<AlgorithmType: EAAlgorithmProtocol, PopulationType>: EAAlgorithmParametersProtocol where AlgorithmType.PopulationType == PopulationType {
    
    public let populationCount: UInt
    public let generationsCount: UInt
    public let fitnessFunction: AlgorithmType.FitnessFunctionType
    
    public let output: EAAlgorithmParametersOutput
    
    /// Algorithm delegate.
    public var delegate: EAAlgorithmDelegate<AlgorithmType, PopulationType>?

    /**
     Create a new algorithm parameters.
     
     - Parameter populationCount: Size of the population.
     - Parameter generationsCount: Number of generations.
     - Parameter fitnessFunction: Problem to be solved defined by fitness function.
     - Parameter output: Desired output data of an algorithm.
     - Parameter delegate: Delegate of an algorithm.
     */
    public init(populationCount: UInt, generationsCount: UInt, fitnessFunction: AlgorithmType.FitnessFunctionType, output: EAAlgorithmParametersOutput = .defaultOutput, delegate: EAAlgorithmDelegate<AlgorithmType, PopulationType>? = nil) throws {
        if populationCount == 0 {
            throw EAAlgorithmParametersError.populationIsZero
        }
        if generationsCount == 0 {
            throw EAAlgorithmParametersError.generationsIsZero
        }
        
        self.populationCount = populationCount
        self.generationsCount = generationsCount
        self.fitnessFunction = fitnessFunction
        self.output = output
        self.delegate = delegate
    }
    
}
