//
//  EAFitnessFunctionProtocol.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public protocol EAFitnessFunctionProtocol {
    
    associatedtype IndividualType: EAIndividualProtocol
    
    var dimension: Int { get }
    var domainValidation: EAFitnessFunctionDomainValidationProtocol? { get }
    
    func evaluate(individual: IndividualType) -> Double
    func getRandomIndividual(type: EADistributionType<IndividualType.DataType>) -> IndividualType
    func validateDomains(individual: IndividualType) -> IndividualType
    
}
