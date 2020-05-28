//
//  EASingleRangeDomainValidation.swift
//  EAKit
//
//  Created by Libor Polehna on 27/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EASingleRangeDomainValidation<IndividualType: EAIndividualProtocol>: EAFitnessFunctionDomainValidationProtocol where IndividualType.DataType: Comparable {
    
    public let domains: [EARangeDomain<IndividualType.DataType>]
    
    private var rangeDomain: EARangeDomain<IndividualType.DataType> {
        return domains.first!
    }
    
    public init(domain: EARangeDomain<IndividualType.DataType>) {
        domains = [domain]
    }
    
    public func validate<FitnessFunction>(individual: IndividualType, fitnessFunction: FitnessFunction) -> IndividualType? where FitnessFunction : EAFitnessFunctionProtocol, IndividualType == FitnessFunction.IndividualType {
        var individual = individual
        for domainIndex in 0 ..< individual.data.count {
            if let value = rangeDomain.validate(value: individual.data[domainIndex]) {
                individual.data[domainIndex] = value
            }
        }
        return individual
    }
    
}
