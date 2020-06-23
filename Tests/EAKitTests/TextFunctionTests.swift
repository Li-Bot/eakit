//
//  TextFunctionTests.swift
//  EAKit
//
//  Created by Libor Polehna on 10/06/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import XCTest

class TextFunctionTests: XCTestCase {
    
    private var fitnessFunction: EATextFunction!
    
    override func setUp() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator())
        fitnessFunction = EATextFunction(text: "ZwTq")
    }

    func testRandomIndividual() {
        let individual = fitnessFunction.getRandomIndividual(type: .uniform)
        print(individual.data.map({ String($0) }).joined())
        XCTAssertEqual(individual.data.map({ String($0) }).joined(), "ZwXq")
    }
    
    func testIndividualFitnessValue() {
        let individual = fitnessFunction.getRandomIndividual(type: .uniform)
        print(individual.fitness)
        XCTAssertEqual(individual.fitness, 1.0)
    }

}
