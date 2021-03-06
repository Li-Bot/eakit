//
//  EAGASinglePointCrossover.swift
//  EAKit
//
//  Created by Libor Polehna on 19/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Specific case of k-point crossover, where k = 1.
 */
public final class EASinglePointCrossover<IndividualType: EAIndividualProtocol>: EAKPointCrossover<IndividualType> {
    
    /**
     Create a new single point crossover.
    
     - Parameter threshold: Treshold which defines if crossover will be performed or not. This parameter has to be in <0.0;1.0>.
    */
    public init(threshold: Double) {
        super.init(threshold: threshold, k: 1)
    }
    
}
