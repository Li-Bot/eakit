//
//  EAArtificialLandscapeFunction.swift
//  EAKit
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public class EAArtificialLandscapeFunction: EAFitnessFunctionProtocol {
    
    public let dimension: Int
    public let range: ClosedRange<Double>
    
    public init(dimension: Int, range: ClosedRange<Double>) {
        self.dimension = dimension
        self.range = range
    }
    
    public func evaluate(individual: EADoubleIndividual) -> Double {
        fatalError("evaluation has not been implemented yet")
    }
    
    public func getRandomIndividual(type: EADistributionType<EADoubleIndividual.DataType>) -> EADoubleIndividual {
        let individual = EADoubleIndividual()
        
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
    
    public func getRandomPopulation(type: EADistributionType<EADoubleIndividual.DataType>, size: UInt) -> EAPopulation<EADoubleIndividual> {
        let population = PopulationType(individuals: [getRandomIndividual(type: type)])
        
        for _ in 0 ..< (size - 1) {
            let individual = getRandomIndividual(type: type)
            population.append(individual: individual)
        }
        
        return population
    }
    
}
