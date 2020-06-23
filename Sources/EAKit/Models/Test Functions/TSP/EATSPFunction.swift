//
//  EATSPFunction.swift
//  EAKit
//
//  Created by Libor Polehna on 20/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 General Fitness Fuction for Travelling Salesman Problem.
 */
public class EATSPFunction: EAFitnessFunctionProtocol {

    public let dimension: Int
    /// Cities
    public let cities: [EATSPCity]
    /// Dimension of the problem, which equals to number of cities.
    public let range: ClosedRange<Int>
    
    /// Distances between each other.
    private var distances: [String : Double]
    
    /**
     Create a new tsp fitness function.
     
     - Parameter cities: Cities where you want to find the shortest path.
     */
    public init(cities: [EATSPCity]) {
        self.dimension = cities.count
        self.cities = cities
        self.range = 0 ... cities.count
        distances = [:]
        
        generateDistancesMatrix()
    }
    
    public func evaluate(individual: EAIndividual<EATSPCity>) -> Double {
        var fitness = 0.0
        let cordsCount = individual.data.count
        
        for (firstIndex, firstCity) in individual.data.enumerated() {
            let secondCity = firstIndex == cordsCount - 1 ? individual.data[0] : individual.data[firstIndex + 1]
            fitness += (distances[getKey(of: firstCity, secondCity)] ?? distances[getKey(of: secondCity, firstCity)])!
        }

        return fitness
    }
    
    public func getRandomIndividual(type: EADistributionType<EATSPCity>) -> EAIndividual<EATSPCity> {
        let individual = EAIndividual<EATSPCity>()
        individual.data = cities.shuffled(using: &EAKit.randomNumberGenerator)
        individual.fitness = evaluate(individual: individual)
        return individual
    }
    
    public func validateDomains(individual: EAIndividual<EATSPCity>) -> EAIndividual<EATSPCity> {
        return individual
    }
    
    /**
     Calculate all distances between all cities.
     */
    private func generateDistancesMatrix() {
        for firstIndex in 0 ..< dimension {
            for secondIndex in firstIndex ..< dimension {
                let firstCity = cities[firstIndex]
                let secondCity = cities[secondIndex]
                let key = getKey(of: firstCity, secondCity)
                
                if firstIndex == secondIndex {
                    continue
                }
                
                var distance = 0.0
                for index in 0 ..< firstCity.coordinates.count {
                    distance += pow2(firstCity.coordinates[index] - secondCity.coordinates[index])
                }
                
                distances[key] = sqrt(distance)
            }
        }
    }
    
    /**
     Get unified key of two cities.
     
     - Parameter firstCity: First city.
     - Parameter secondCity: Second city.
     
     - Returns: The key of two cities.
     */
    private func getKey(of firstCity: EATSPCity, _ secondCity: EATSPCity) -> String {
        return "\(firstCity.id)\(secondCity.id)"
    }
    
}
