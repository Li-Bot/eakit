//
//  GeneticAlgorithmTests.swift
//  EAKit
//
//  Created by Libor Polehna on 12/06/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import XCTest


class GeneticAlgorithmTests: XCTestCase {

    func testGeneticAlgorithm() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator(seed: 42))

        let desiredText = "Libor Polehna"
        let fitnessFunction = EATextFunction(text: desiredText)
        let parameters = try! EAGeneticAlgorithmParameters(
            populationCount: 20,
            generationsCount: 2000,
            fitnessFunction: fitnessFunction,
            isElitism: true,
            selection: EARouletteSelection(isElitism: true),
            crossover: EATwoPointCrossover(threshold: 1.0),
            mutation: EAReplacementMutation(threshold: 1.0, count: 1, set: fitnessFunction.characters),
            output: .defaultOutput,
            delegate: nil
        )
        let algorithm = EAGeneticAlgorithm(parameters: parameters)
        let result = algorithm.run()
        XCTAssertEqual(result.bestPopulation.bestIndividual!.data.map({ String($0) }).joined(), desiredText)
    }

}
