//
//  EAAlgorithmDelegate.swift
//  EAKit
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Abstract algorithm delegate protocol.
 */
public protocol EAAlgorithmDelegateProtocol {
    
    /// Generic Algorithm type.
    associatedtype AlgorithmType: EAAlgorithmProtocol
    /// Generic Population type.
    associatedtype PopulationType: EAPopulationProtocol
    
    /**
     Method is called when an algorithm finishes a generation. You can use this method to update your UI on the main thread to show a progress.
     
     - Parameter algorithm: Algorithm which is currently running.
     - Parameter generation: Generation which was just finished.
     - Parameter population: Population of current generation. 
     */
    func eaAlgorithm(_ algorithm: AlgorithmType, didFinishGeneration generation: UInt, population:  PopulationType)
    
}
