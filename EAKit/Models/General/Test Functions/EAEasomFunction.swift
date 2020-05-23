//
//  EAEasomFunction.swift
//  EAKit
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EAEasomFunction<IndividualType: EADoubleIndividual>: EAArtificialLandscapeFunction<IndividualType> {
    
    public init() {
        super.init(dimension: 2, domainValidation: nil, range: -100.0 ... 100.0)
    }
    
    public override func evaluate(individual: IndividualType) -> Double {
        let x = individual.data[0]
        let y = individual.data[1]
        return -cos(x) * cos(y) * exp(-(pow2(x - Double.pi) + pow2(y - Double.pi)))
    }
    
}
