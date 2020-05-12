//
//  EAFitnessFunctionProtocol.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public protocol EAFitnessFunctionProtocol {
    
    associatedtype PopulationType: EAPopulationProtocol
    
    var dimension: Int { get }
    
    func evaluate(individual: PopulationType.IndividualType) -> Double
    func getRandomIndividual(type: EADistributionType<PopulationType.IndividualType.DataType>) -> PopulationType.IndividualType
    func getRandomPopulation(type: EADistributionType<PopulationType.IndividualType.DataType>, size: UInt) -> PopulationType
    
}
