//
//  EAKit_macOSTests.swift
//  EAKit-macOSTests
//
//  Created by Libor Polehna on 08/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import XCTest
@testable import EAKit_macOS

class EAKit_macOSTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testHillClimbing() {
        let hillClimbing: EAHillClimbing<EASphereFunction, EAPopulation> = EAHillClimbing(populationCount: 10, fitnessFunction: EASphereFunction(), iterationsCount: 5, deviation: 0.3)
        let result = hillClimbing.run()
        print(result.bestIndividual.fitness)
        print(result.bestIndividual.data)
    }

}
