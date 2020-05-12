//
//  EAGATSPCrossover.swift
//  EAKit
//
//  Created by Libor Polehna on 20/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public class EAGATSPSinglePointCrossover: EAGeneticAlgorithmCrossoverProtocol {
    
    public let threshold: Double
    
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
        /*var firstDelta = size - firstIndividual.data.count
        for city in second.data {
            if firstDelta == 0 {
                break
            }
            if firstExistingCities.contains(city.id) {
                continue
            }
            firstIndividual.data.append(city)
            firstExistingCities.insert(city.id)
            firstDelta -= 1
        }*/
        
        fill(individual: secondIndividual, from: first, existingCities: secondExistingCities, size: size)
        /*var secondDelta = size - secondIndividual.data.count
        for city in first.data {
            if secondDelta == 0 {
                break
            }
            if secondExistingCities.contains(city.id) {
                continue
            }
            secondIndividual.data.append(city)
            secondExistingCities.insert(city.id)
            secondDelta -= 1
        }*/
        
        return [firstIndividual, secondIndividual]
    }
    
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
