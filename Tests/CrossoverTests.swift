//
//  CrossoverTests.swift
//  EAKit
//
//  Created by Libor Polehna on 11/06/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import XCTest


class CrossoverTests: XCTestCase {

    override func setUp() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator())
    }
    
    func testSinglePointCrossover() {
        let firstIndividual = EACharacterIndividual()
        firstIndividual.data = ["T", "e", "s", "t"]
        let secondIndividual = EACharacterIndividual()
        secondIndividual.data = ["2", "0", "2", "0"]
        let crossover = EASinglePointCrossover<EACharacterIndividual>(threshold: 1.0)
        let offsprings = crossover.cross(first: firstIndividual, second: secondIndividual)
        XCTAssertEqual(offsprings[0].data, ["T", "e", "2", "0"])
        XCTAssertEqual(offsprings[1].data, ["2", "0", "s", "t"])
    }
    
    func testTwoPointCrossover() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator(seed: 2020))
        let firstIndividual = EACharacterIndividual()
        firstIndividual.data = ["T", "e", "s", "t", "s", "y"]
        let secondIndividual = EACharacterIndividual()
        secondIndividual.data = ["2", "0", "2", "0", "1", "3"]
        let crossover = EATwoPointCrossover<EACharacterIndividual>(threshold: 1.0)
        let offsprings = crossover.cross(first: firstIndividual, second: secondIndividual)
        XCTAssertEqual(offsprings[0].data, ["T", "0", "2", "0", "s", "y"])
        XCTAssertEqual(offsprings[1].data, ["2", "e", "s", "t", "1", "3"])
    }
    
    func testThreePointCrossover() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator(seed: 2020))
        let firstIndividual = EACharacterIndividual()
        firstIndividual.data = ["T", "e", "s", "t", "s", "y"]
        let secondIndividual = EACharacterIndividual()
        secondIndividual.data = ["2", "0", "2", "0", "1", "3"]
        let crossover = EAKPointCrossover<EACharacterIndividual>(threshold: 1.0, k: 3)
        let offsprings = crossover.cross(first: firstIndividual, second: secondIndividual)
        XCTAssertEqual(offsprings[0].data, ["T", "0", "2", "t", "1", "3"])
        XCTAssertEqual(offsprings[1].data, ["2", "e", "s", "0", "s", "y"])
    }
    
    func testUniformCrossover() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator(seed: 2020))
        let firstIndividual = EACharacterIndividual()
        firstIndividual.data = ["T", "e", "s", "t"]
        let secondIndividual = EACharacterIndividual()
        secondIndividual.data = ["2", "0", "2", "0"]
        let crossover = EAUniformCrossover<EACharacterIndividual>(threshold: 1.0)
        let offsprings = crossover.cross(first: firstIndividual, second: secondIndividual)
        XCTAssertEqual(offsprings[0].data, ["T", "e", "2", "t"])
        XCTAssertEqual(offsprings[1].data, ["2", "0", "s", "0"])
    }
    
    func testDifferentialEvolutionCrossover() {
        let firstIndividual = EACharacterIndividual()
        firstIndividual.data = ["T", "e", "s", "t"]
        let secondIndividual = EACharacterIndividual()
        secondIndividual.data = ["2", "0", "2", "0"]
        let crossover = EADifferentialEvolutionCrossover<EACharacterIndividual>(cr: 0.9)
        let offsprings = crossover.cross(first: firstIndividual, second: secondIndividual)
        XCTAssertEqual(offsprings[0].data, ["2", "e", "2", "0"])
        XCTAssertEqual(offsprings[1].data, ["T", "0", "s", "t"])
    }

}
