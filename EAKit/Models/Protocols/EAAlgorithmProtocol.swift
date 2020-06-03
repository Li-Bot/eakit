//
//  EAAlgorithm.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Abstract eavolutionary algorithm protocol.
 */
public protocol EAAlgorithmProtocol {
    
    /// Generic Fitness Function type.
    associatedtype FitnessFunctionType: EAFitnessFunctionProtocol
    /// Generic Population type.
    associatedtype PopulationType: EAPopulationProtocol 
    
    /**
     Run the algorithm. You are responsible to run an algorithm in a background thread if you do not want to block the main thread.
     
     - Returns: Result of algorithm.
     */
    func run() -> EAAlgorithmResult<PopulationType>
    
}
