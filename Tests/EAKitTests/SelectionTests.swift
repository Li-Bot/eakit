//
//  SelectionTests.swift
//  EAKit
//
//  Created by Libor Polehna on 11/06/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import XCTest


class SelectionTests: XCTestCase {
    
    override func setUp() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator())
    }

    func testRandomSelection() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator())
        let fitnessFunction = EASphereFunction()
        let population = EAPopulation<EADoubleIndividual>.getRandomPopulation(type: .uniform, fitnessFunction: fitnessFunction, size: 10, context: nil)
        let selection = EARandomSelection<EAPopulation<EADoubleIndividual>>()
        selection.prepare(population: population, context: nil)
        let parents = selection.selectParents(population: population, count: 2, context: nil)
        XCTAssertEqual(parents[0].data, population.individuals[7].data)
        XCTAssertEqual(parents[1].data, population.individuals[0].data)
    }
    
    func testRouletteSelection() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator(seed: 2014))
        
        let fitnessFunction = EASphereFunction()
        let population = EAPopulation<EADoubleIndividual>.getRandomPopulation(type: .uniform, fitnessFunction: fitnessFunction, size: 10, context: nil)
        var selection = EARouletteSelection<EAPopulation<EADoubleIndividual>>()
        selection.prepare(population: population, context: nil)
        let parents = selection.selectParents(population: population, count: 2, context: nil)
        XCTAssertEqual(parents[0].data, population.individuals[3].data)
        XCTAssertEqual(parents[1].data, population.individuals[4].data)
    }
    
    func testTournamentSelection() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator(seed: 2014))
        
        let fitnessFunction = EASphereFunction()
        let population = EAPopulation<EADoubleIndividual>.getRandomPopulation(type: .uniform, fitnessFunction: fitnessFunction, size: 10, context: nil)
        let selection = EATournamentSelection<EAPopulation<EADoubleIndividual>>(tournamentSize: 5)
        selection.prepare(population: population, context: nil)
        let parents = selection.selectParents(population: population, count: 2, context: nil)
        XCTAssertEqual(parents[0].data, population.individuals[1].data)
        XCTAssertEqual(parents[1].data, population.individuals[6].data)
    }
    
}
