//
//  EAEvolutionaryStrategy.swift
//  EAKit
//
//  Created by Libor Polehna on 07/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EAEvolutionaryStrategy<FitnessFunctionType: EAFitnessFunctionProtocol, SelectionType: EASelectionProtocol, RecombinationType: EAEvolutionaryStrategyRecombinationProtocol, MutationType: EAMutationProtocol>: EAAlgorithmProtocol where SelectionType.PopulationType == EAPopulation<FitnessFunctionType.IndividualType>, FitnessFunctionType.IndividualType == RecombinationType.IndividualType, FitnessFunctionType.IndividualType == MutationType.IndividualType {
    
    private typealias OffspringsTuple = (offsprings: [FitnessFunctionType.IndividualType], offspringsPointersHashes: Set<Int>)
    
    public let parameters: EAEvolutionaryStrategyParameters<FitnessFunctionType, SelectionType, RecombinationType, MutationType>
    
    private let uniformUnifiedDistribution = EAUniformDistribution(range: 0.0 ... 1.0)
    
    private var context: EAEvolutionaryStrategyContext?
    
    public init(parameters: EAEvolutionaryStrategyParameters<FitnessFunctionType, SelectionType, RecombinationType, MutationType>) {
        self.parameters = parameters
    }
    
    public func run() -> EAAlgorithmResult<SelectionType.PopulationType> {
        var currentPopulation = PopulationType.getRandomPopulation(type: .uniform, fitnessFunction: parameters.fitnessFunction, size: parameters.populationCount, context: nil)
        let result = EAAlgorithmResult(population: currentPopulation)
        
        for generationIndex in 0 ..< parameters.generationsCount - 1 {
            parameters.selection.prepare(population: currentPopulation, context: context)
            parameters.mutation.prepare(context: context)
            
            var offspringsTuple = getOffsprings(population: &currentPopulation)
            
            if parameters.configuration.selectionStrategy == .plus {
                offspringsTuple.offsprings.append(contentsOf: currentPopulation.individuals)
            }
            
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
    
    private func getOffsprings(population: inout PopulationType) -> OffspringsTuple {
        var offsprings = [PopulationType.IndividualType]()
        var offspringsPointersHashes = Set<Int>()
        
        for _ in 0 ..< parameters.configuration.λ {
            let parents = parameters.selection.selectParents(population: population, count: Int(parameters.configuration.ρ), context: context)
            var offspring = parameters.recombination.recombine(individuals: parents)
            
            if uniformUnifiedDistribution.random() <= parameters.mutation.threshold {
                offspring = parameters.mutation.mutate(individual: offspring, context: context)
            }
            offspring = parameters.fitnessFunction.validateDomains(individual: offspring)
            offspring.fitness = parameters.fitnessFunction.evaluate(individual: offspring)
            
            offsprings.append(offspring)
            let id = Unmanaged.passUnretained(offspring as AnyObject).toOpaque()
            offspringsPointersHashes.insert(id.hashValue)
        }
        
        return (offsprings, offspringsPointersHashes)
    }
    
    private func getContext(offspringsTuple: inout OffspringsTuple) -> EAEvolutionaryStrategyContext {
        var betterCount = 0
        for offspring in offspringsTuple.offsprings {
            let id = Unmanaged.passUnretained(offspring as AnyObject).toOpaque()
            if offspringsTuple.offspringsPointersHashes.contains(id.hashValue) {
                betterCount += 1
            }
        }
        let betterRatio = Double(betterCount) / Double(offspringsTuple.offsprings.count)
        return EAEvolutionaryStrategyContext(betterRatio: betterRatio)
    }
    
}
