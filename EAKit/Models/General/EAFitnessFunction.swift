//
//  EAFitnessFunction.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public class EAFitnessFunction<IndividualType, DomainValidationType: EAFitnessFunctionDomainValidationProtocol>: EAFitnessFunctionProtocol where DomainValidationType.IndividualType == IndividualType {
    
    public let dimension: Int
    private let domainValidation: DomainValidationType?
    
    public init(dimension: Int, domainValidation: DomainValidationType?) {
        self.dimension = dimension
        self.domainValidation = domainValidation
    }
    
    public func evaluate(individual: IndividualType) -> Double {
        fatalError("evaluation has not been implemented yet")
    }
    
    public func getRandomIndividual(type: EADistributionType<IndividualType.DataType>) -> IndividualType {
        fatalError("getRandomIndividual has not been implemented yet")
    }
    
    public func validateDomains(individual: IndividualType) -> IndividualType {
        domainValidation?.validate(individual: individual, fitnessFunction: self) ?? individual
    }
    
}
