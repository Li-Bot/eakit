//
//  ArtificialLandscapeFunctionTests.swift
//  EAKit
//
//  Created by Libor Polehna on 08/06/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import XCTest


class ArtificialLandscapeFunctionTests: XCTestCase {

    func testSphereFunction() throws {
        let individual = EADoubleIndividual()
        individual.data = [0.0, 0.0]
        individual.fitness = EASphereFunction().evaluate(individual: individual)
        XCTAssertEqual(individual.fitness, 0.0)
    }
    
    func testRosenbrockFunction() throws {
        let individual = EADoubleIndividual()
        individual.data = [1.0, 1.0]
        individual.fitness = EARosenbrockFunction().evaluate(individual: individual)
        XCTAssertEqual(individual.fitness, 0.0)
    }
    
    func testRastriginFunction() throws {
        let individual = EADoubleIndividual()
        individual.data = [0.0, 0.0]
        individual.fitness = EARastriginFunction().evaluate(individual: individual)
        XCTAssertEqual(individual.fitness, 0.0)
    }
    
    func testAckleyFunction() throws {
        let individual = EADoubleIndividual()
        individual.data = [0.0, 0.0]
        individual.fitness = EAAckleyFunction().evaluate(individual: individual)
        XCTAssertEqual(individual.fitness, 0.0, accuracy: 0.0001)
    }
    
    func testSchwefelFunction() throws {
        let individual = EADoubleIndividual()
        individual.data = [420.9687, 420.9687]
        individual.fitness = EASchwefelFunction().evaluate(individual: individual)
        XCTAssertEqual(individual.fitness, 0.0, accuracy: 0.0001)
    }
    
    func testEasomFunction() throws {
        let individual = EADoubleIndividual()
        individual.data = [Double.pi, Double.pi]
        individual.fitness = EAEasomFunction().evaluate(individual: individual)
        XCTAssertEqual(individual.fitness, -1.0)
    }

}
