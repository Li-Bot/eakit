//
//  EASchwefelFunction.swift
//  EAKit
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EASchwefelFunction<IndividualType: EADoubleIndividual>: EAArtificialLandscapeFunction<IndividualType> {
    
    public init(dimension: Int = 2) {
        super.init(dimension: dimension, domainValidation: nil, range: -500.0 ... 500.0)
    }
    
    public override func evaluate(individual: IndividualType) -> Double {
        let d = Double(individual.data.count)
        var fitness = 418.9829 * d
        for x in individual.data {
            fitness -= x * sin(sqrt(fabs(x)))
        }
        return fitness
    }
    
}
