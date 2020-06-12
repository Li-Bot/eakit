//
//  DomainTests.swift
//  EAKit
//
//  Created by Libor Polehna on 10/06/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import XCTest


class DomainTests: XCTestCase {

    func testRangeDomainMaximum() {
        let domain = EARangeDomain(range: 0 ... 10)
        let validated = domain.validate(value: 15)
        XCTAssertEqual(validated, 10)
    }
    
    func testRangeDomainMinimum() {
        let domain = EARangeDomain(range: 0 ... 10)
        let validated = domain.validate(value: -5)
        XCTAssertEqual(validated, 0)
    }
    
    func testSingleDomainValidation() {
        let fitnessFunction = EASphereFunction()
        let validation = EASingleRangeDomainValidation<EADoubleIndividual>(domain: EARangeDomain(range: fitnessFunction.range))
        let individual = EADoubleIndividual()
        individual.data = [-10.0, 10.0]
        let validated = validation.validate(individual: individual, fitnessFunction: fitnessFunction)
        XCTAssertEqual(validated?.data, [fitnessFunction.range.lowerBound, fitnessFunction.range.upperBound])
    }

}
