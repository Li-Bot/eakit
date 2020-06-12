//
//  HillClimbingTests.swift
//  EAKit
//
//  Created by Libor Polehna on 12/06/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import XCTest


class HillClimbingTests: XCTestCase {

    func testHillClimbing() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator())
        let parameters = try! EAHillClimbingParameters(
            populationCount: 10,
            generationsCount: 300,
            fitnessFunction: EASphereFunction(),
            deviation: 0.5,
            output: .defaultOutput,
            delegate: nil
        )
        let algorithm = EAHillClimbing(parameters: parameters)
        let result = algorithm.run()
        XCTAssertLessThan(result.bestPopulation.bestIndividual!.fitness, 0.001)
    }

}
