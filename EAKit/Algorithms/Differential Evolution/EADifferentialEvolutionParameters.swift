//
//  EADifferentialEvolutionParameters.swift
//  EAKit
//
//  Created by Libor Polehna on 24/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Parameters of Differential Evolution Algorithm.
*/
public final class EADifferentialEvolutionParameters<FitnessFunctionType: EAFitnessFunctionProtocol, SelectionType: EASelectionProtocol, MutationStrategyType: EADifferentialEvolutionMutationStrategyProtocol, CrossoverType: EACrossoverProtocol>: EAAlgorithmParameters<EADifferentialEvolution<FitnessFunctionType, SelectionType, MutationStrategyType, CrossoverType>, EAPopulation<FitnessFunctionType.IndividualType>> where FitnessFunctionType.IndividualType == CrossoverType.IndividualType, EAPopulation<FitnessFunctionType.IndividualType> == SelectionType.PopulationType, FitnessFunctionType.IndividualType == MutationStrategyType.IndividualType {
    
    /// Number of individuals in the population.
    public var np: UInt {
        populationCount
    }
    
    /// Parents selection strategy.
    public var selection: SelectionType
    /// Individuals mutation strategy.
    public let mutationStrategy: MutationStrategyType
    /// Parents crossover strategy.
    public let crossover: CrossoverType
    
    /**
     Create a new Differential Evolution parameters.
    
     - Parameter populationCount: Number of individuals.
     - Parameter generationsCount: Number of generations.
     - Parameter selection: Parents selection strategy.
     - Parameter mutationStrategy: Individuals mutation strategy.
     - Parameter crossover: Parents crossover strategy.
     - Parameter fitnessFunction: Problem to be solved defined by fitness function.
     - Parameter output: Desired output data of an algorithm.
     - Parameter delegate: Delegate of the algorithm.
    */
    public init(populationCount: UInt, generationsCount: UInt, selection: SelectionType, mutationStrategy: MutationStrategyType, crossover: CrossoverType, fitnessFunction: FitnessFunctionType, output: EAAlgorithmParametersOutput = .defaultOutput, delegate: EAAlgorithmDelegate<EADifferentialEvolution<FitnessFunctionType, SelectionType, MutationStrategyType, CrossoverType>, EAPopulation<FitnessFunctionType.IndividualType>>? = nil) throws {
        self.selection = selection
        self.mutationStrategy = mutationStrategy
        self.crossover = crossover
        try super.init(populationCount: populationCount, generationsCount: generationsCount, fitnessFunction: fitnessFunction, output: output, delegate: delegate)
    }
    
}
