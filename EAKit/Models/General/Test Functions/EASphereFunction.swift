//
//  EASphereFunction.swift
//  EAKit
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EASphereFunction<IndividualType: EADoubleIndividual>: EAArtificialLandscapeFunction<IndividualType> {
    
    public init(dimension: Int = 2) {
        super.init(dimension: dimension, domainValidation: nil, range: -5.0 ... 5.0)
    }
    
    public override func evaluate(individual: IndividualType) -> Double {
        var fitness: Double = 0.0
        for x in individual.data {
            fitness += x * x
        }
        return fitness
    }
    
}
