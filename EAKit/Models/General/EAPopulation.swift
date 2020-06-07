//
//  EAPopulation.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 General population with generic individual type.
 */
public class EAPopulation<IndividualType: EAIndividualProtocol>: EAPopulationProtocol {
    
    public class func getRandomIndividual<FitnessFunction>(type: EADistributionType<IndividualType.DataType>, fitnessFunction: FitnessFunction, context: EAContextProtocol?) -> IndividualType where FitnessFunction : EAFitnessFunctionProtocol, IndividualType == FitnessFunction.IndividualType {
        return fitnessFunction.getRandomIndividual(type: type)
    }
    
    public class func getRandomPopulation<FitnessFunction>(type: EADistributionType<IndividualType.DataType>, fitnessFunction: FitnessFunction, size: UInt, context: EAContextProtocol?) -> Self<IndividualType> where FitnessFunction : EAFitnessFunctionProtocol, IndividualType == FitnessFunction.IndividualType {
        let population = Self(individuals: [getRandomIndividual(type: type, fitnessFunction: fitnessFunction, context: context)])
        
        for _ in 0 ..< (size - 1) {
            let individual = getRandomIndividual(type: type, fitnessFunction: fitnessFunction, context: context)
            population.append(individual: individual)
        }
        
        return population
    }
    
    public var bestIndividual: IndividualType? {
        if let index = bestIndividualIndex {
            return individuals[index]
        }
        return nil
    }
    
    public private(set) var individuals: [IndividualType]
    
    /// Index of the best individual in the population.
    private var bestIndividualIndex: Int?
    
    public required init(individuals: [IndividualType]) {
        self.individuals = []
        bestIndividualIndex = nil
        append(individuals: individuals)
    }
    
    public func append(individual: IndividualType) {
        individuals.append(individual)
        if bestIndividual == nil || individual.fitness < bestIndividual!.fitness {
            bestIndividualIndex = individuals.count - 1
        }
    }
    
    public func append(individuals: [IndividualType]) {
        self.individuals.append(contentsOf: individuals)
        for (index, individual) in individuals.enumerated() {
            if bestIndividual == nil || individual.fitness < bestIndividual!.fitness {
                bestIndividualIndex = self.individuals.count - individuals.count + index
            }
        }
    }
    
}
