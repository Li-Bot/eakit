//
//  CoreComponentsTests.swift
//  EAKit
//
//  Created by Libor Polehna on 08/06/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import XCTest


class PopulationTests: XCTestCase {
    
    func testPopulationRandomIndividual() throws {
        let individual = EAIndividual<Int>()
        individual.fitness = 1.0
        let population = EAPopulation<EAIndividual<Int>>(individuals: [])
        population.append(individual: individual)
        XCTAssertEqual(population.individuals.count, 1)
    }
    
    func testPopulationAddIndividual() throws {
        let individual = EAIndividual<Int>()
        individual.fitness = 1.0
        let population = EAPopulation<EAIndividual<Int>>(individuals: [])
        population.append(individual: individual)
        XCTAssertEqual(population.individuals.count, 1)
    }
    
    func testPopulationAddMultipleIndividual() throws {
        let individual = EAIndividual<Int>()
        individual.fitness = 1.0
        let population = EAPopulation<EAIndividual<Int>>(individuals: [])
        population.append(individuals: [individual])
        XCTAssertEqual(population.individuals.count, 1)
    }

    func testPopulationTheBestIndividual() throws {
        let individual = EAIndividual<Int>()
        individual.fitness = 1.0
        let population = EAPopulation(individuals: [individual])
        let betterIndividual = EAIndividual<Int>()
        betterIndividual.fitness = 0.0
        population.append(individual: betterIndividual)
        XCTAssertEqual(population.bestIndividual?.fitness, 0.0)
    }
    
    func testPopulationTheBestMultipleIndividual() throws {
        let individual = EAIndividual<Int>()
        individual.fitness = 1.0
        let population = EAPopulation(individuals: [individual])
        let betterIndividual = EAIndividual<Int>()
        betterIndividual.fitness = 0.0
        population.append(individuals: [betterIndividual])
        XCTAssertEqual(population.bestIndividual?.fitness, 0.0)
    }
    

}
