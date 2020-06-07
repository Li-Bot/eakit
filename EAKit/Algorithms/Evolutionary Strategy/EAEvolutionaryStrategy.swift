//
//  EAEvolutionaryStrategy.swift
//  EAKit
//
//  Created by Libor Polehna on 07/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Evolutionary Strategy Algorithm.
*/
public final class EAEvolutionaryStrategy<FitnessFunctionType: EAFitnessFunctionProtocol, SelectionType: EASelectionProtocol, RecombinationType: EAEvolutionaryStrategyRecombinationProtocol, MutationType: EAMutationProtocol>: EAAlgorithmProtocol where SelectionType.PopulationType == EAPopulation<FitnessFunctionType.IndividualType>, FitnessFunctionType.IndividualType == RecombinationType.IndividualType, FitnessFunctionType.IndividualType == MutationType.IndividualType {
    
    /// Tuple which holds offsprings and their hashes of their addresses in a set.
    private typealias OffspringsTuple = (offsprings: [FitnessFunctionType.IndividualType], offspringsPointersHashes: Set<Int>)
    
    /// Parameters of the algorithm.
    public let parameters: EAEvolutionaryStrategyParameters<FitnessFunctionType, SelectionType, RecombinationType, MutationType>
    
    /// Unified uniform distribution.
    private let uniformUnifiedDistribution = EAUniformDistribution(range: 0.0 ... 1.0)
    
    /// Context of additional metadata.
    private var context: EAEvolutionaryStrategyContext?
    
    /**
     Create a new Evolutionary Strategy Algorithm.
    
     - Parameter parameters: Parameters of the algorithm.
    */
    public init(parameters: EAEvolutionaryStrategyParameters<FitnessFunctionType, SelectionType, RecombinationType, MutationType>) {
        self.parameters = parameters
    }
    
    public func run() -> EAAlgorithmResult<SelectionType.PopulationType> {
        var currentPopulation = PopulationType.getRandomPopulation(type: .uniform, fitnessFunction: parameters.fitnessFunction, size: parameters.populationCount, context: nil)
        let result = EAAlgorithmResult(population: currentPopulation)
        
        for generationIndex in 0 ..< parameters.generationsCount - 1 {
            parameters.selection.prepare(population: currentPopulation, context: context)
            parameters.mutation.prepare(context: context)
            
            // Create new offsprings.
            var offspringsTuple = getOffsprings(population: &currentPopulation)
            
            // Append parents if the plus strategy is enabled, otherwise use only offsprings.
            if parameters.configuration.selectionStrategy == .plus {
                offspringsTuple.offsprings.append(contentsOf: currentPopulation.individuals)
            }
            
            // Get population-size the best individuals.
            offspringsTuple.offsprings = Array(offspringsTuple.offsprings.sorted(by: { firstIndividual, secondIndividual in
                return firstIndividual.fitness < secondIndividual.fitness
            }).prefix(upTo: Int(currentPopulation.size)))
            
            context = getContext(offspringsTuple: &offspringsTuple)
            currentPopulation = PopulationType(individuals: offspringsTuple.offsprings)
            
            result.append(population: currentPopulation, keepBestOnly: parameters.output.saveProgress)
            parameters.delegate?.didFinishGeneration?(self, generationIndex, currentPopulation)
        }
        
        return result
    }
    
    /**
     Create new offsprings from current population.
     
     - Parameter population: Current population.
     
     - Returns: New offsprings and their hashes of their addresses.
     */
    private func getOffsprings(population: inout PopulationType) -> OffspringsTuple {
        var offsprings = [PopulationType.IndividualType]()
        var offspringsPointersHashes = Set<Int>()
        
        for _ in 0 ..< parameters.configuration.λ {
            // Select parents.
            let parents = parameters.selection.selectParents(population: population, count: Int(parameters.configuration.ρ), context: context)
            // Recombine parents.
            var offspring = parameters.recombination.recombine(individuals: parents)
            
            // Mutate offspring.
            if uniformUnifiedDistribution.random() <= parameters.mutation.threshold {
                offspring = parameters.mutation.mutate(individual: offspring, context: context)
            }
            // Validate offspring.
            offspring = parameters.fitnessFunction.validateDomains(individual: offspring)
            // Evaluate offspring.
            offspring.fitness = parameters.fitnessFunction.evaluate(individual: offspring)
            
            // Get the address of the offspring.
            offsprings.append(offspring)
            let id = Unmanaged.passUnretained(offspring as AnyObject).toOpaque()
            offspringsPointersHashes.insert(id.hashValue)
        }
        
        return (offsprings, offspringsPointersHashes)
    }
    
    /**
     Create context of additional metadata.
     
     - Parameter offspringsTuple: Offsprings and their hashes of their addresses.
     
     - Returns: Context of additional metadata.
     */
    private func getContext(offspringsTuple: inout OffspringsTuple) -> EAEvolutionaryStrategyContext {
        var betterCount = 0
        // Calculate how many new individuals are better than their parents in the previous population. In other words how many new individuals will be in the new population.
        for offspring in offspringsTuple.offsprings {
            let id = Unmanaged.passUnretained(offspring as AnyObject).toOpaque()
            if offspringsTuple.offspringsPointersHashes.contains(id.hashValue) {
                betterCount += 1
            }
        }
        // Normalize value.
        let betterRatio = Double(betterCount) / Double(offspringsTuple.offsprings.count)
        return EAEvolutionaryStrategyContext(betterRatio: betterRatio)
    }
    
}
