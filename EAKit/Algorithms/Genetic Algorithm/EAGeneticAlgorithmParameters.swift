//
//  EAGeneticAlgorithmParameters.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 15/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EAGeneticAlgorithmParameters<FitnessFunctionType: EAFitnessFunctionProtocol, SelectionType: EAGeneticAlgorithmSelectionProtocol, CrossoverType: EAGeneticAlgorithmCrossoverProtocol, MutationType: EAGeneticAlgorithmMutationProtocol>: EAAlgorithmParameters<EAGeneticAlgorithm<FitnessFunctionType, SelectionType, CrossoverType, MutationType>> where FitnessFunctionType.PopulationType == SelectionType.PopulationType, FitnessFunctionType.PopulationType.IndividualType == CrossoverType.IndividualType, FitnessFunctionType.PopulationType.IndividualType == MutationType.IndividualType {
    
    public var isElitism: Bool
    public var selection: SelectionType
    public var crossover: CrossoverType
    public var mutation: MutationType

    public init(populationCount: UInt, generationsCount: UInt, fitnessFunction: FitnessFunctionType, isElitism: Bool, selection: SelectionType, crossover: CrossoverType, mutation: MutationType, output: EAAlgorithmParametersOutput = .defaultOutput, delegate: EAAlgorithmDelegate<EAGeneticAlgorithm<FitnessFunctionType, SelectionType, CrossoverType, MutationType>>? = nil) throws {
        self.isElitism = isElitism
        self.selection = selection
        self.crossover = crossover
        self.mutation = mutation
        
        try super.init(populationCount: populationCount, generationsCount: generationsCount, fitnessFunction: fitnessFunction, output: output, delegate: delegate)
    }
    
}
