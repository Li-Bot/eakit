//
//  ParticleSwarmTests.swift
//  EAKit
//
//  Created by Libor Polehna on 12/06/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import XCTest


class ParticleSwarmTests: XCTestCase {
    
    override func setUp() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator())
    }
    
    func testBestPositionIndividual() {
        let individual = EAParticleSwarmIndividual()
        individual.position = [2.0, 2.0]
        individual.fitness = 1.0
        XCTAssertEqual(individual.bestPosition, individual.position)
        individual.position = [1.0, 1.0]
        individual.fitness = 0.1
        XCTAssertEqual(individual.bestPosition, individual.position)
    }

    func testCopyIndividual() {
        let individual = EAParticleSwarmIndividual()
        individual.position = [2.0, 2.0]
        individual.fitness = 1.0
        individual.velocity = [0.5, 0.5]
        let copyIndividual = individual.copy()
        XCTAssertEqual(individual.position, copyIndividual.position)
        XCTAssertEqual(individual.bestPosition, copyIndividual.bestPosition)
        XCTAssertEqual(individual.fitness, copyIndividual.fitness)
        XCTAssertEqual(individual.velocity, copyIndividual.velocity)
    }
    
    func testRandomIndividual() {
        let context = EAParticleSwarmContext(velocity: EAParticleSwarmVelocity(maximum: 5.0))
        let individual = EAParticleSwarmPopulation.getRandomIndividual(type: .uniform, fitnessFunction: EASphereFunction(), context: context)
        XCTAssertEqual(individual.position, [0.79084614598290415, 4.0886835995794968])
        XCTAssertEqual(individual.velocity, [0.41071305555430371, 3.2592511628440235])
    }

    func testParticleSwarm() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator(seed: 42))
        
        let parameters = try! EAParticleSwarmParameters(
            particlesCount: 30,
            iterationsCount: 1000,
            velocity: EAParticleSwarmVelocity(maximum: EASphereFunction().distance / 30.0),
            learning: .defaultLearning,
            inertiaWeight: .defaultInertiaWeight,
            fitnessFunction: EASphereFunction(),
            output: .defaultOutput,
            delegate: nil
        )
        let algorithm = EAParticleSwarm(parameters: parameters)
        let result = algorithm.run()
        XCTAssertLessThan(result.bestPopulation.bestIndividual!.fitness, 0.001)
    }
    
}
