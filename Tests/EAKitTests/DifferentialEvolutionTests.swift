//
//  DifferentialEvolutionTests.swift
//  EAKit
//
//  Created by Libor Polehna on 12/06/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import XCTest


class DifferentialEvolutionTests: XCTestCase {

    override func setUp() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator())
    }
    
    func testRand1BinMutationStrategy() {
        let firstIndividual = EADoubleIndividual()
        firstIndividual.data = [1.0, 2.0]
        let secondIndividual = EADoubleIndividual()
        secondIndividual.data = [3.0, 4.0]
        let thirdIndividual = EADoubleIndividual()
        thirdIndividual.data = [5.0, 6.0]
        let mutation = EADERand1BinMutationStrategy<EADoubleIndividual>(f: 0.5, λ: 0.5)
        let mutatedIndividual = mutation.mutate(activeIndividual: firstIndividual, bestIndividual: firstIndividual, individuals: [firstIndividual, secondIndividual, thirdIndividual], context: EADifferentialEvolutionContext())
        XCTAssertEqual(mutatedIndividual.data, [4.0, 5.0])
    }

    func testDifferentialEvolution() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator(seed: 42))
        
        let parameters = try! EADifferentialEvolutionParameters(
            populationCount: 10,
            generationsCount: 20,
            selection: EARandomSelection(),
            mutationStrategy: EADERand1BinMutationStrategy(f: 0.5, λ: 0.5),
            crossover: EADifferentialEvolutionCrossover(cr: 0.9),
            fitnessFunction: EASphereFunction(),
            output: .defaultOutput,
            delegate: nil
        )
        let algorithm = EADifferentialEvolution(parameters: parameters)
        let result = algorithm.run()
        XCTAssertLessThan(result.bestPopulation.bestIndividual!.fitness, 0.001)
    }
    
}
