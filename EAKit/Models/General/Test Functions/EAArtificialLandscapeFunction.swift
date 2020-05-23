//
//  EAArtificialLandscapeFunction.swift
//  EAKit
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public class EAArtificialLandscapeFunction<IndividualType: EADoubleIndividual>: EAFitnessFunctionProtocol {
    
    public let dimension: Int
    public let domainValidation: EAFitnessFunctionDomainValidationProtocol?
    public let range: ClosedRange<Double>
    
    public var distance: Double {
        range.upperBound - range.lowerBound
    }
    
    public init(dimension: Int, domainValidation: EAFitnessFunctionDomainValidationProtocol?, range: ClosedRange<Double>) {
        self.dimension = dimension
        self.domainValidation = domainValidation
        self.range = range
    }
    
    public func evaluate(individual: IndividualType) -> Double {
        fatalError("evaluation has not been implemented yet")
    }
    
    public func getRandomIndividual(type: EADistributionType<IndividualType.DataType>) -> IndividualType {
        let individual = IndividualType()
        
        var distribution: EAUniformDistribution<Double>!
        for dimension in 0 ..< dimension {
            let randomValue: Double
            switch type {
            case .uniform:
                distribution = (distribution ?? EAUniformDistribution(range: range))
                randomValue = distribution.random()
            case .normal(let μ, let σ):
                randomValue = EANormalDistribution(μ: μ[dimension], σ: σ).random()
            }

            individual.data.append(randomValue)
        }
        individual.fitness = evaluate(individual: individual)
        
        return individual
    }
    
    public func validateDomains(individual: IndividualType) -> IndividualType {
        return domainValidation?.validate(individual: individual, fitnessFunction: self) ?? individual
    }
    
}
