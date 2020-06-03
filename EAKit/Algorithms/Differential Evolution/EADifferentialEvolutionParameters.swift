//
//  EADifferentialEvolutionParameters.swift
//  EAKit
//
//  Created by Libor Polehna on 24/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EADifferentialEvolutionParameters<FitnessFunctionType: EAFitnessFunctionProtocol, SelectionType: EASelectionProtocol, MutationStrategyType: EADifferentialEvolutionMutationStrategyProtocol, CrossoverType: EAGeneticAlgorithmCrossoverProtocol>: EAAlgorithmParameters<EADifferentialEvolution<FitnessFunctionType, SelectionType, MutationStrategyType, CrossoverType>, EAPopulation<FitnessFunctionType.IndividualType>> where FitnessFunctionType.IndividualType == CrossoverType.IndividualType, EAPopulation<FitnessFunctionType.IndividualType> == SelectionType.PopulationType, FitnessFunctionType.IndividualType == MutationStrategyType.IndividualType {
    
    public var np: UInt {
        populationCount
    }
    
    let selection: SelectionType
    let mutationStrategy: MutationStrategyType
    let crossover: CrossoverType

    public init(populationCount: UInt, generationsCount: UInt, selection: SelectionType, mutationStrategy: MutationStrategyType, crossover: CrossoverType, fitnessFunction: FitnessFunctionType, output: EAAlgorithmParametersOutput = .defaultOutput, delegate: EAAlgorithmDelegate<EADifferentialEvolution<FitnessFunctionType, SelectionType, MutationStrategyType, CrossoverType>, EAPopulation<FitnessFunctionType.IndividualType>>? = nil) throws {
        self.selection = selection
        self.mutationStrategy = mutationStrategy
        self.crossover = crossover
        try super.init(populationCount: populationCount, generationsCount: generationsCount, fitnessFunction: fitnessFunction, output: output, delegate: delegate)
    }
    
}
