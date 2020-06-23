//
//  EAAckleyFunction.swift
//  EAKit
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Ackley Test Fitness Function.
 Specific artificial landscape test fitness function.
*/
public final class EAAckleyFunction<IndividualType: EADoubleIndividual>: EAArtificialLandscapeFunction<IndividualType> {
    
    /// Control parameter a.
    let a: Double
    /// Control parameter b.
    let b: Double
    /// Control parameter c.
    let c: Double
    
    /**
     Create a new Ackley fitness function.
    
     - Parameter dimension: Dimension of landscape.
     - Parameter a: Control parameter a.
     - Parameter b: Control parameter b.
     - Parameter c: Control parameter c.
    */
    public init(dimension: Int = 2, a: Double = 20.0, b: Double = 0.2, c: Double = 2.0 * Double.pi) {
        self.a = a
        self.b = b
        self.c = c
        super.init(dimension: dimension, range: -5.0 ... 5.0)
    }
    
    public override func evaluate(individual: IndividualType) -> Double {
        let d = Double(individual.data.count)
        let reverseD = 1 / d

        let sphereFunction = EASphereFunction(dimension: dimension)
        var fitness = -a * exp(-b * sqrt(reverseD * sphereFunction.evaluate(individual: individual)))
        var sum: Double = 0.0
        for x in individual.data {
            sum += cos(c * x)
        }
        fitness -= exp(reverseD * sum)
        return fitness + a + exp(1.0)
    }
    
}
