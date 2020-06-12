//
//  MutationTests.swift
//  EAKit
//
//  Created by Libor Polehna on 12/06/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import XCTest


class MutationTests: XCTestCase {

    override func setUp() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator())
    }
    
    func testSwapMutation() {
        let individual = EACharacterIndividual()
        individual.data = ["T", "e", "s", "t"]
        let mutation = EASwapMutation<EACharacterIndividual>(threshold: 1.0, count: 1)
        let offspring = mutation.mutate(individual: individual, context: nil)
        XCTAssertEqual(offspring.data, ["T", "e", "t", "s"])
    }
    
    func testFloatingNumericMutation() {
        let individual = EADoubleIndividual()
        individual.data = [0.1, 0.2, 0.3, 0.4]
        let mutation = EAFloatingNumericMutation<EADoubleIndividual>(threshold: 1.0, count: 1, increment: 0.1)
        let offspring = mutation.mutate(individual: individual, context: nil)
        XCTAssertEqual(offspring.data, [0.1, 0.2, 0.4, 0.4])
    }
    
    func testReplacementMutation() {
        let individual = EACharacterIndividual()
        individual.data = ["T", "e", "s", "t"]
        let mutation = EAReplacementMutation<EACharacterIndividual>(threshold: 1.0, count: 1, set: [Character("A")])
        let offspring = mutation.mutate(individual: individual, context: nil)
        XCTAssertEqual(offspring.data, ["T", "e", "A", "t"])
    }
    
    func testNormalDistributionMutation() {
        let individual = EADoubleIndividual()
        individual.data = [0.1, 0.2, 0.3, 0.4]
        let mutation = EANormalDistributionMutation<EADoubleIndividual>(threshold: 1.0, σ: 0.5)
        let offspring = mutation.mutate(individual: individual, context: nil)
        XCTAssertEqual(offspring.data, [0.53927782399196389, 0.45445282200235654, 0.0027321958120598011, 0.36812672891053677])
    }

}
