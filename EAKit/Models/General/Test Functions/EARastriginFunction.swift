//
//  EARastriginFunction.swift
//  EAKit
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EARastriginFunction<IndividualType: EADoubleIndividual>: EAArtificialLandscapeFunction<IndividualType> {
    
    public let a: Double
    
    public init(dimension: Int = 2, a: Double = 10.0) {
        self.a = a
        super.init(dimension: dimension, range: -5.12 ... 5.12)
    }
    
    public override func evaluate(individual: IndividualType) -> Double {
        let count = Double(individual.data.count)
        var fitness = a * count
        for x in individual.data {
            fitness += x * x - a * cos(2.0 * Double.pi * x)
        }
        return fitness
    }
    
}
