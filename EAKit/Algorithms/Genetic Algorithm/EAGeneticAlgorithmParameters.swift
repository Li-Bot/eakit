//
//  EAGeneticAlgorithmParameters.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 15/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EAGeneticAlgorithmParameters<FitnessFunctionType: EAFitnessFunctionProtocol, SelectionType: EASelectionProtocol, CrossoverType: EAGeneticAlgorithmCrossoverProtocol, MutationType: EAMutationProtocol>: EAAlgorithmParameters<EAGeneticAlgorithm<FitnessFunctionType, SelectionType, CrossoverType, MutationType>, EAPopulation<FitnessFunctionType.IndividualType>> where FitnessFunctionType.IndividualType == CrossoverType.IndividualType, FitnessFunctionType.IndividualType == MutationType.IndividualType, SelectionType.PopulationType == EAPopulation<FitnessFunctionType.IndividualType> {
    
    public var isElitism: Bool
    public var selection: SelectionType
    public var crossover: CrossoverType
    public var mutation: MutationType

    public init(populationCount: UInt, generationsCount: UInt, fitnessFunction: FitnessFunctionType, isElitism: Bool, selection: SelectionType, crossover: CrossoverType, mutation: MutationType, output: EAAlgorithmParametersOutput = .defaultOutput, delegate: EAAlgorithmDelegate<EAGeneticAlgorithm<FitnessFunctionType, SelectionType, CrossoverType, MutationType>, EAPopulation<FitnessFunctionType.IndividualType>>? = nil) throws {
        self.isElitism = isElitism
        self.selection = selection
        self.crossover = crossover
        self.mutation = mutation
        
        try super.init(populationCount: populationCount, generationsCount: generationsCount, fitnessFunction: fitnessFunction, output: output, delegate: delegate)
    }
    
}
