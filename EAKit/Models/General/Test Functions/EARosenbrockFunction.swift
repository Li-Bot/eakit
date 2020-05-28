//
//  EARosenbrockFunction.swift
//  EAKit
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EARosenbrockFunction<IndividualType: EADoubleIndividual>: EAArtificialLandscapeFunction<IndividualType> {
    
    public init(dimension: Int = 2) {
        super.init(dimension: dimension, range: -5.0 ... 5.0)
    }
    
    public override func evaluate(individual: IndividualType) -> Double {
        var fitness: Double = 0.0
        for index in 0 ..< individual.data.count - 1 {
            let x = individual.data[index]
            fitness += 100.0 * pow2(individual.data[index + 1] - x * x)
            fitness += pow2(1.0 - x)
        }
        return fitness
    }
    
}
