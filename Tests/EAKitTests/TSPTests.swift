//
//  TSPTests.swift
//  EAKit
//
//  Created by Libor Polehna on 09/06/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import XCTest


class TSPFunctionTests: XCTestCase {
    
    private var fitnessFunction: EATSPFunction!
    
    override func setUp() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator())
        
        let cities = [
            EATSPCity("A", [60.0, 200.0]),
            EATSPCity("B", [80.0, 200.0]),
            EATSPCity("C", [80.0, 180.0]),
            EATSPCity("D", [140.0, 180.0]),
            EATSPCity("E", [20.0, 160.0]),
            EATSPCity("F", [100.0, 160.0]),
            EATSPCity("G", [200.0, 160.0]),
            EATSPCity("H", [140.0, 140.0]),
            EATSPCity("I", [40.0, 120.0]),
            EATSPCity("J", [100.0, 120.0]),
            EATSPCity("K", [180.0, 100.0]),
            EATSPCity("L", [60.0, 80.0]),
            EATSPCity("M", [120.0, 80.0]),
            EATSPCity("N", [180.0, 60.0]),
            EATSPCity("O", [20.0, 40.0]),
            EATSPCity("P", [100.0, 40.0]),
            EATSPCity("Q", [200.0, 40.0]),
            EATSPCity("R", [20.0, 20.0]),
            EATSPCity("S", [60.0, 20.0]),
            EATSPCity("T", [160.0, 20.0])
        ]
        fitnessFunction = EATSPFunction(cities: cities)
    }
    
    func testRandomIndividual() {
        let individual = fitnessFunction.getRandomIndividual(type: .uniform)
        print(individual.data.map({ $0.id }).joined())
        XCTAssertEqual(individual.data.map({ $0.id }).joined(), "LSARPKBFTQCNJGIHEDMO")
    }
    
    func testIndividualFitnessValue() {
        let individual = fitnessFunction.getRandomIndividual(type: .uniform)
        XCTAssertEqual(individual.fitness, 2314.7990633374316, accuracy: 0.00001)
    }
    
    func testSinglePointCrossover() {
        let firstIndividual = fitnessFunction.getRandomIndividual(type: .uniform)
        let secondIndividual = fitnessFunction.getRandomIndividual(type: .uniform)
        let crossover = EATSPSinglePointCrossover(threshold: 1.0)
        let offsprings = crossover.cross(first: firstIndividual, second: secondIndividual)
        XCTAssertEqual(offsprings[0].data.map({ $0.id }).joined(), "LSARPKBFJICMDHQNTOEG")
        XCTAssertEqual(offsprings[1].data.map({ $0.id }).joined(), "TPOEBSAGFJKICLMDHQRN")
    }
    
    func testTwoPointCrossover() {
        let firstIndividual = fitnessFunction.getRandomIndividual(type: .uniform)
        let secondIndividual = fitnessFunction.getRandomIndividual(type: .uniform)
        let crossover = EATSPTwoPointCrossover(threshold: 1.0)
        let offsprings = crossover.cross(first: firstIndividual, second: secondIndividual)
        print(offsprings[0].data.map({ $0.id }).joined())
        print(offsprings[1].data.map({ $0.id }).joined())
        XCTAssertEqual(offsprings[0].data.map({ $0.id }).joined(), "LSARPKBFJICMDHQNTOEG")
        XCTAssertEqual(offsprings[1].data.map({ $0.id }).joined(), "TPOEBSAGFJKICLMDHQRN")
    }
    
}
