//
//  EAAlgorithmParameters.swift
//  EAKit
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public class EAAlgorithmParameters<AlgorithmType: EAAlgorithmProtocol, PopulationType: EAPopulationProtocol>: EAAlgorithmParametersProtocol where AlgorithmType.PopulationType == PopulationType {
    
    public let populationCount: UInt
    public let generationsCount: UInt
    public let fitnessFunction: AlgorithmType.FitnessFunctionType
    
    public let output: EAAlgorithmParametersOutput
    
    public var delegate: EAAlgorithmDelegate<AlgorithmType, PopulationType>?

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
