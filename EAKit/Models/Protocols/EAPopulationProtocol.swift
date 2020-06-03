//
//  EAPopulationProtocol.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Abstract population protocol.
*/
public protocol EAPopulationProtocol {
    
    /// Generic Individual type.
    associatedtype IndividualType: EAIndividualProtocol
    
    /**
     Create new random individual defined by `fitnessFunction`.
     
     - Parameter type: Distribution type of new individual.
     - Parameter fitnessFunction: Fitness Function which is responsible for valid data of individual.
     - Parameter context: Additional metadata.
     
     - Returns: New Individual.
     */
    static func getRandomIndividual<FitnessFunction: EAFitnessFunctionProtocol>(type: EADistributionType<IndividualType.DataType>, fitnessFunction: FitnessFunction, context: EAContextProtocol?) -> IndividualType where FitnessFunction.IndividualType == IndividualType
    /**
     Create new random population defined by `fitnessFunction`.
    
     - Parameter type: Distribution type of new individual.
     - Parameter fitnessFunction: Fitness Function which is responsible for valid data of individuals.
     - Parameter size: Number of individuals in population.
     - Parameter context: Additional metadata.
    
     - Returns: New population.
    */
    static func getRandomPopulation<FitnessFunction: EAFitnessFunctionProtocol>(type: EADistributionType<IndividualType.DataType>, fitnessFunction: FitnessFunction, size: UInt, context: EAContextProtocol?) -> Self where FitnessFunction.IndividualType == IndividualType
    
    /**
     Create new population.
     
     - Parameter individuals: Initial individuals of new population.
     */
    init(individuals: [IndividualType])
    
    /// Best individual in the population according to its fitness value.
    var bestIndividual: IndividualType? { get }
    /// Individuals in the population.
    var individuals: [IndividualType] { get }
    
    /**
     Add new individual to the population.
     
     - Parameter individual: New individual.
     */
    func append(individual: IndividualType)
    /**
    Add new individuals to the population.
    
    - Parameter individuals: New individuals.
    */
    func append(individuals: [IndividualType])
    
}


public extension EAPopulationProtocol {
    
    /// Size of population. In other words number of individuals in population.
    var size: UInt {
        return UInt(individuals.count)
    }
    
}
