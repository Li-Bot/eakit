//
//  EATSPFunction.swift
//  EAKit
//
//  Created by Libor Polehna on 20/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public class EATSPFunction: EAFitnessFunctionProtocol {

    public let dimension: Int
    public let cities: [EATSPCity]
    public let range: ClosedRange<Int>
    
    private var distances: [String : Double]
    
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
        individual.data = cities.shuffled()
        individual.fitness = evaluate(individual: individual)
        return individual
    }
    
    public func getRandomPopulation(type: EADistributionType<EATSPCity>, size: UInt) -> EAPopulation<EAIndividual<EATSPCity>> {
        let population = PopulationType(individuals: [getRandomIndividual(type: type)])
        
        var sum = population.bestIndividual!.fitness
        for _ in 0 ..< (size - 1) {
            let individual = getRandomIndividual(type: type)
            population.append(individual: individual)
            sum += individual.fitness
        }
        
        return population
    }
    
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
    
    private func getKey(of firstCity: EATSPCity, _ secondCity: EATSPCity) -> String {
        return "\(firstCity.id)\(secondCity.id)"
    }
    
}
