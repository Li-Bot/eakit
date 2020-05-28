//
//  EAGASinglePointCrossover.swift
//  EAKit
//
//  Created by Libor Polehna on 19/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EASinglePointCrossover<IndividualType: EAIndividualProtocol>: EAKPointCrossover<IndividualType> {
    
    public init(threshold: Double) {
        super.init(threshold: threshold, k: 1)
    }
    
}
