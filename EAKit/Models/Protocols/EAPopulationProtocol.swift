//
//  EAPopulationProtocol.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public protocol EAPopulationProtocol {
    
    associatedtype IndividualType: EAIndividualProtocol
    
    static func getRandomIndividual<FitnessFunction: EAFitnessFunctionProtocol>(type: EADistributionType<IndividualType.DataType>, fitnessFunction: FitnessFunction, context: EAContextProtocol?) -> IndividualType where FitnessFunction.IndividualType == IndividualType
    static func getRandomPopulation<FitnessFunction: EAFitnessFunctionProtocol>(type: EADistributionType<IndividualType.DataType>, fitnessFunction: FitnessFunction, size: UInt, context: EAContextProtocol?) -> Self where FitnessFunction.IndividualType == IndividualType
    
    init(individuals: [IndividualType])
    
    var bestIndividual: IndividualType? { get }
    var individuals: [IndividualType] { get }
    
    func append(individual: IndividualType)
    func append(individuals: [IndividualType])
    
}


public extension EAPopulationProtocol {
    
    var size: UInt {
        return UInt(individuals.count)
    }
    
}
