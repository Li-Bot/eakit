//
//  EAGATSPCrossover.swift
//  EAKit
//
//  Created by Libor Polehna on 20/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Single point crossover for TSP Problem.
 */
public class EATSPSinglePointCrossover: EACrossoverProtocol {
    
    public let threshold: Double
    
    /**
     Create a new TSP single point crossover.
    
     - Parameter threshold: Treshold which defines if crossover will be performed or not. This parameter has to be in <0.0;1.0>.
    */
    public init(threshold: Double) {
        self.threshold = threshold
    }
    
    public final func cross(first: EAIndividual<EATSPCity>, second: EAIndividual<EATSPCity>) -> [EAIndividual<EATSPCity>] {
        let size = first.data.count
        let range = size > 2 ? 1 ... (size - 2) : 1 ... 1
        let uniformDistribution = EAUniformDistribution(range: range)
        let index = uniformDistribution.random()
        let firstIndividual = IndividualType()
        let secondIndividual = IndividualType()
        firstIndividual.data = Array(first.data.prefix(upTo: index))
        secondIndividual.data = Array(second.data.prefix(upTo: index))
        var firstExistingCities = Set(firstIndividual.data.map({ $0.id }))
        var secondExistingCities = Set(secondIndividual.data.map({ $0.id }))
        
        for cityIndex in index ..< size {
            let firstCity = second.data[cityIndex]
            if !firstExistingCities.contains(firstCity.id) {
                firstIndividual.data.append(firstCity)
                firstExistingCities.insert(firstCity.id)
            }
            let secondCity = second.data[cityIndex]
            if !secondExistingCities.contains(secondCity.id) {
                secondIndividual.data.append(secondCity)
                secondExistingCities.insert(secondCity.id)
            }
        }
        
        fill(individual: firstIndividual, from: second, existingCities: firstExistingCities, size: size)
        fill(individual: secondIndividual, from: first, existingCities: secondExistingCities, size: size)
        
        return [firstIndividual, secondIndividual]
    }
    
    /**
     Fill the remaining cities of an individual.
     
     - Parameter individual: Individual to be filled.
     - Parameter from: Individual where the remaining cities come from.
     - Parameter existingCities: Already existing cities in the `individual`.
     - Parameter size: Number of cities.
     */
    private func fill(individual: IndividualType, from: IndividualType, existingCities: Set<String>, size: Int) {
        var existingCities = existingCities
        var delta = size - individual.data.count
        for city in from.data {
            if delta == 0 {
                break
            }
            if existingCities.contains(city.id) {
                continue
            }
            individual.data.append(city)
            existingCities.insert(city.id)
            delta -= 1
        }
    }
    
}
