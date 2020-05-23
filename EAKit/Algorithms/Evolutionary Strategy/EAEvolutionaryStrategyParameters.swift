//
//  EAEvolutionaryStrategyParameters.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 12/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EAEvolutionaryStrategyParameters<FitnessFunctionType: EAFitnessFunctionProtocol, SelectionType: EASelectionProtocol, RecombinationType: EAEvolutionaryStrategyRecombinationProtocol, MutationType: EAMutationProtocol>: EAAlgorithmParameters<EAEvolutionaryStrategy<FitnessFunctionType, SelectionType, RecombinationType, MutationType>, EAPopulation<FitnessFunctionType.IndividualType>> where SelectionType.PopulationType == EAPopulation<FitnessFunctionType.IndividualType>, FitnessFunctionType.IndividualType == RecombinationType.IndividualType, FitnessFunctionType.IndividualType == MutationType.IndividualType {
    
    public var configuration: EAEvolutionaryStrategyConfiguration
    public var selection: SelectionType
    public var recombination: RecombinationType
    public var mutation: MutationType

    public init(generationsCount: UInt, configuration: EAEvolutionaryStrategyConfiguration, fitnessFunction: FitnessFunctionType, selection: SelectionType, recombination: RecombinationType, mutation: MutationType, output: EAAlgorithmParametersOutput = .defaultOutput, delegate: EAAlgorithmDelegate<EAEvolutionaryStrategy<FitnessFunctionType, SelectionType, RecombinationType, MutationType>, EAPopulation<FitnessFunctionType.IndividualType>>? = nil) throws {
        self.configuration = configuration
        self.selection = selection
        self.recombination = recombination
        self.mutation = mutation
        
        try super.init(populationCount: configuration.µ, generationsCount: generationsCount, fitnessFunction: fitnessFunction, output: output, delegate: delegate)
    }
    
}
