//
//  CoreComponentsTests.swift
//  EAKit
//
//  Created by Libor Polehna on 08/06/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import XCTest


class PopulationTests: XCTestCase {
    
    override func setUp() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator())
    }
    
    func testPopulationRandomIndividual() throws {
        let fitnessFunction = EASphereFunction<EADoubleIndividual>(dimension: 2)
        let individual = EAPopulation<EADoubleIndividual>.getRandomIndividual(type: .uniform, fitnessFunction: fitnessFunction, context: nil)
        XCTAssertEqual(individual.data, [0.79084614598290415, 4.0886835995794968])
        XCTAssertEqual(individual.fitness, 17.342771204086365, accuracy: 0.00001)
    }
    
    func testPopulationRandomPopulation() throws {
        let size: UInt = 300
        let fitnessFunction = EASphereFunction<EADoubleIndividual>()
        let population = EAPopulation<EADoubleIndividual>.getRandomPopulation(type: .uniform, fitnessFunction: fitnessFunction, size: size, context: nil)
        XCTAssertEqual(population.individuals.count, Int(size))
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
