//
//  EvolutionaryStrategyTests.swift
//  EAKit
//
//  Created by Libor Polehna on 12/06/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import XCTest


class EvolutionaryStrategyTests: XCTestCase {
    
    override func setUp() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator())
    }
    
    func testNormalMutation() throws {
        let mutation = EAESNormalMutation<EADoubleIndividual>(threshold: 1.0, σ: 0.2)
        let individual = EADoubleIndividual()
        individual.data = [0.0, 0.0]
        let mutatedIndividual = mutation.mutate(individual: individual, context: nil)
        XCTAssertEqual(mutatedIndividual.data, [0.17571112959678556, 0.10178112880094262])
    }
    
    func testIntermadiateRecombination() {
        let firstIndividual = EADoubleIndividual()
        firstIndividual.data = [1.0, 2.0]
        let secondIndividual = EADoubleIndividual()
        secondIndividual.data = [2.0, 3.0]
        let recombination = EAESIntermadiateRecombination()
        let recombinant = recombination.recombine(individuals: [firstIndividual, secondIndividual])
        XCTAssertEqual(recombinant.data, [1.5, 2.5])
    }
    
    func testDiscreteRecombination() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator(seed: 42))
        
        let firstIndividual = EADoubleIndividual()
        firstIndividual.data = [1.0, 2.0]
        let secondIndividual = EADoubleIndividual()
        secondIndividual.data = [2.0, 3.0]
        let recombination = EAESDiscreteRecombination<EADoubleIndividual>()
        let recombinant = recombination.recombine(individuals: [firstIndividual, secondIndividual])
        XCTAssertEqual(recombinant.data, [2.0, 2.0])
    }

    func testEvolutionaryStrategy() {
        let configuration = try! EAEvolutionaryStrategyConfiguration(µ: 20, ρ: 2, selectionStrategy: .plus, λ: 20)
        let parameters = try! EAEvolutionaryStrategyParameters(
            generationsCount: 2000,
            configuration: configuration,
            fitnessFunction: EASphereFunction(),
            selection: EARandomSelection(),
            recombination: EAESIntermadiateRecombination(),
            mutation: EAESNormalMutation(threshold: 1.0, σ: 0.5),
            output: .defaultOutput,
            delegate: nil
        )
        let algorithm = EAEvolutionaryStrategy(parameters: parameters)
        let result = algorithm.run()
        XCTAssertLessThan(result.bestPopulation.bestIndividual!.fitness, 0.0001)
    }

}
