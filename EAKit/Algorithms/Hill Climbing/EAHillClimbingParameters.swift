//
//  EAHillClimbingParameters.swift
//  EAKit
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EAHillClimbingParameters<FitnessFunctionType: EAFitnessFunctionProtocol>: EAAlgorithmParameters<EAHillClimbing<FitnessFunctionType>, EAPopulation<FitnessFunctionType.IndividualType>> {
    
    public let deviation: FitnessFunctionType.IndividualType.DataType

    public init(populationCount: UInt, generationsCount: UInt, fitnessFunction: FitnessFunctionType, deviation: FitnessFunctionType.IndividualType.DataType, output: EAAlgorithmParametersOutput = .defaultOutput, delegate: EAAlgorithmDelegate<EAHillClimbing<FitnessFunctionType>, EAPopulation<FitnessFunctionType.IndividualType>>? = nil) throws {
        self.deviation = deviation
        
        try super.init(populationCount: populationCount, generationsCount: generationsCount, fitnessFunction: fitnessFunction, output: output, delegate: delegate)
    }
    
}
