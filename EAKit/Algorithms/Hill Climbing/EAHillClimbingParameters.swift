//
//  EAHillClimbingParameters.swift
//  EAKit
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Parameters of Hill Climbing Algorithm.
 */
public final class EAHillClimbingParameters<FitnessFunctionType: EAFitnessFunctionProtocol>: EAAlgorithmParameters<EAHillClimbing<FitnessFunctionType>, EAPopulation<FitnessFunctionType.IndividualType>> {
    
    /// Deviation for normal distribution. It is used for climbing.
    public let deviation: FitnessFunctionType.IndividualType.DataType

    /**
     Create a new Hill Climbing parameters.
     
     - Parameter populationCount: Number of individuals.
     - Parameter generationsCount: Number of generations.
     - Parameter fitnessFunction: Problem to be solved defined by fitness function.
     - Parameter deviation: Deviation, which is used for climbing.
     - Parameter output: Desired output data of an algorithm.
     - Parameter delegate: Delegate of the algorithm.
     */
    public init(populationCount: UInt, generationsCount: UInt, fitnessFunction: FitnessFunctionType, deviation: FitnessFunctionType.IndividualType.DataType, output: EAAlgorithmParametersOutput = .defaultOutput, delegate: EAAlgorithmDelegate<EAHillClimbing<FitnessFunctionType>, EAPopulation<FitnessFunctionType.IndividualType>>? = nil) throws {
        self.deviation = deviation
        
        try super.init(populationCount: populationCount, generationsCount: generationsCount, fitnessFunction: fitnessFunction, output: output, delegate: delegate)
    }
    
}
