//
//  EAGeneticAlgorithmParameters.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 15/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Parameters of Genetic Algorithm.
*/
public final class EAGeneticAlgorithmParameters<FitnessFunctionType: EAFitnessFunctionProtocol, SelectionType: EASelectionProtocol, CrossoverType: EACrossoverProtocol, MutationType: EAMutationProtocol>: EAAlgorithmParameters<EAGeneticAlgorithm<FitnessFunctionType, SelectionType, CrossoverType, MutationType>, EAPopulation<FitnessFunctionType.IndividualType>> where FitnessFunctionType.IndividualType == CrossoverType.IndividualType, FitnessFunctionType.IndividualType == MutationType.IndividualType, SelectionType.PopulationType == EAPopulation<FitnessFunctionType.IndividualType> {
    
    /// If true the best individual will be selected to the next population from parents and offsprings, otherwise offspring will be always selected.
    public var isElitism: Bool
    /// Parents selection strategy.
    public var selection: SelectionType
    /// Parents crossover strategy.
    public var crossover: CrossoverType
    /// Offsprings mutation strategy.
    public var mutation: MutationType

    /**
     Create a new Gentic Algorithm parameters.
    
     - Parameter populationCount: Number of individuals.
     - Parameter generationsCount: Number of generations.
     - Parameter fitnessFunction: Problem to be solved defined by fitness function.
     - Parameter isElitism: If true the best individual will be selected to the next population from parents and offsprings, otherwise offspring will be always selected.
     - Parameter selection: Parents selection strategy.
     - Parameter crossover: Parents crossover strategy.
     - Parameter mutation: Offsprings mutation strategy.
     - Parameter output: Desired output data of an algorithm.
     - Parameter delegate: Delegate of the algorithm.
    */
    public init(populationCount: UInt, generationsCount: UInt, fitnessFunction: FitnessFunctionType, isElitism: Bool, selection: SelectionType, crossover: CrossoverType, mutation: MutationType, output: EAAlgorithmParametersOutput = .defaultOutput, delegate: EAAlgorithmDelegate<EAGeneticAlgorithm<FitnessFunctionType, SelectionType, CrossoverType, MutationType>, EAPopulation<FitnessFunctionType.IndividualType>>? = nil) throws {
        self.isElitism = isElitism
        self.selection = selection
        self.crossover = crossover
        self.mutation = mutation
        
        try super.init(populationCount: populationCount, generationsCount: generationsCount, fitnessFunction: fitnessFunction, output: output, delegate: delegate)
    }
    
}
