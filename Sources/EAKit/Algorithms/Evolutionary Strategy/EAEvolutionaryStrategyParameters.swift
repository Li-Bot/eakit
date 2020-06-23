//
//  EAEvolutionaryStrategyParameters.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 12/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Parameters of Evolutionary Strategy Algorithm.
*/
public final class EAEvolutionaryStrategyParameters<FitnessFunctionType: EAFitnessFunctionProtocol, SelectionType: EASelectionProtocol, RecombinationType: EAEvolutionaryStrategyRecombinationProtocol, MutationType: EAMutationProtocol>: EAAlgorithmParameters<EAEvolutionaryStrategy<FitnessFunctionType, SelectionType, RecombinationType, MutationType>, EAPopulation<FitnessFunctionType.IndividualType>> where SelectionType.PopulationType == EAPopulation<FitnessFunctionType.IndividualType>, FitnessFunctionType.IndividualType == RecombinationType.IndividualType, FitnessFunctionType.IndividualType == MutationType.IndividualType {
    
    /// Configuration of the algorithm.
    public var configuration: EAEvolutionaryStrategyConfiguration
    /// Parents selection strategy.
    public var selection: SelectionType
    /// Parents recombination strategy.
    public var recombination: RecombinationType
    /// Offsprings mutation strategy.
    public var mutation: MutationType

    /**
     Create a new Evolutionary Strategy parameters.
    
     - Parameter generationsCount: Number of generations.
     - Parameter configuration: Configuration of the algorithm.
     - Parameter fitnessFunction: Problem to be solved defined by fitness function.
     - Parameter selection: Parents selection strategy.
     - Parameter recombination: Parents recombination strategy.
     - Parameter mutation: Offsprings mutation strategy.
     - Parameter output: Desired output data of an algorithm.
     - Parameter delegate: Delegate of the algorithm.
    */
    public init(generationsCount: UInt, configuration: EAEvolutionaryStrategyConfiguration, fitnessFunction: FitnessFunctionType, selection: SelectionType, recombination: RecombinationType, mutation: MutationType, output: EAAlgorithmParametersOutput = .defaultOutput, delegate: EAAlgorithmDelegate<EAEvolutionaryStrategy<FitnessFunctionType, SelectionType, RecombinationType, MutationType>, EAPopulation<FitnessFunctionType.IndividualType>>? = nil) throws {
        self.configuration = configuration
        self.selection = selection
        self.recombination = recombination
        self.mutation = mutation
        
        try super.init(populationCount: configuration.µ, generationsCount: generationsCount, fitnessFunction: fitnessFunction, output: output, delegate: delegate)
    }
    
}
