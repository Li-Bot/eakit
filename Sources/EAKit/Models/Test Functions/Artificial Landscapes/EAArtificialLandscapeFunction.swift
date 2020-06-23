//
//  EAArtificialLandscapeFunction.swift
//  EAKit
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Abstract class for Artificial Landscape Test Fitness Functions.
 */
public class EAArtificialLandscapeFunction<IndividualType: EADoubleIndividual>: EAFitnessFunctionProtocol {
    
    public let dimension: Int
    /// Range for all dimensions.
    public let range: ClosedRange<Double>
    
    /// Domain Validation.
    private let domainValidation: EASingleRangeDomainValidation<IndividualType>
    
    /// Difference between upper bound of the range and lower bound of the range.
    public var distance: Double {
        range.upperBound - range.lowerBound
    }
    
    /**
     Create a new artificial landscape fitness function.
     
     - Parameter dimension: Dimension of n-dimensional landscape.
     - Parameter range: Range for all dimensions.
     */
    public init(dimension: Int, range: ClosedRange<Double>) {
        self.dimension = dimension
        self.range = range
        domainValidation = EASingleRangeDomainValidation(domain: EARangeDomain(range: range))
    }
    
    /**
     Evaluate fitness value of `individual`.
    
     - Parameter individual: Individual to be evaluated.
    
     - Returns: Fitness value of `individual`.
    */
    public func evaluate(individual: IndividualType) -> Double {
        fatalError("evaluation has not been implemented yet")
    }
    
    public func getRandomIndividual(type: EADistributionType<IndividualType.DataType>) -> IndividualType {
        var individual = IndividualType()
        
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
        individual = validateDomains(individual: individual)
        individual.fitness = evaluate(individual: individual)
        
        return individual
    }
    
    public func validateDomains(individual: IndividualType) -> IndividualType {
        return domainValidation.validate(individual: individual, fitnessFunction: self) ?? individual
    }
    
}
