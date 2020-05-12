//
//  EAFitnessFunction.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public class EAFitnessFunction<PopulationType: EAPopulationProtocol>: EAFitnessFunctionProtocol {
    
    public let dimension: Int
    
    public init(dimension: Int) {
        self.dimension = dimension
    }
    
    public func evaluate(individual: PopulationType.IndividualType) -> Double {
        fatalError("evaluation has not been implemented yet")
    }
    
    public func getRandomIndividual(type: EADistributionType<PopulationType.IndividualType.DataType>) -> PopulationType.IndividualType {
        fatalError("getRandomIndividual has not been implemented yet")
    }
    
    public func getRandomPopulation(type: EADistributionType<PopulationType.IndividualType.DataType>, size: UInt) -> PopulationType {
        fatalError("getRandomPopulation has not been implemented yet")
    }
    
}
