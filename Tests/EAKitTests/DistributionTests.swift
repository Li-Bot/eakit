//
//  DistributionTests.swift
//  EAKit
//
//  Created by Libor Polehna on 07/06/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import XCTest


class DistributionTests: XCTestCase {
    
    private let lowerBound = 0.0
    private let upperBound = 1.0
    
    override func setUp() {
        EAKit.randomNumberGenerator = EARandomNumberGeneratorWrapper(generator: FakeRandomNumberGenerator())
    }

    func testUniformDistributionBoundaries() throws {
        let uniformDistribution = EAUniformDistribution(range: lowerBound ... upperBound)
        let randomValue = uniformDistribution.random()
        XCTAssertEqual(randomValue, 0.57908461459829041, accuracy: 0.00001)
    }
    
    func testUniformDistributionCount() throws {
        let count = 10
        let uniformDistribution = EAUniformDistribution(range: lowerBound ... upperBound)
        let randomValues = uniformDistribution.random(count: 10)
        XCTAssertEqual(randomValues.count, count)
    }

    func testUniformDistributionExcept() throws {
        let except = Set([1])
        let uniformDistribution = EAUniformDistribution(range: 0 ... 2)
        let randomValue = uniformDistribution.random(except: except)
        XCTAssertFalse(except.contains(randomValue))
    }
    
    func testUniformDistributionCountDifference() throws {
        let minDifference = 1
        let uniformDistribution = EAUniformDistribution(range: 0 ... 2)
        let randomValues = uniformDistribution.random(count: 2, minimumDifference: minDifference)
        XCTAssertTrue(abs(randomValues[0] - randomValues[1]) >= minDifference)
    }
    
    func testNormalDistributionBoundaries() throws {
        let normalDistribution = EANormalDistribution(μ: 0.0, σ: 0.2)
        let randomValue = normalDistribution.random()
        XCTAssertEqual(randomValue, 0.17571112959678556, accuracy: 0.00001)
    }

}
