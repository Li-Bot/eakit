//
//  EAAlgorithmDelegate.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 General algorithm delegate with generic algorithm type and population type.
 */
public struct EAAlgorithmDelegate<AlgorithmType: EAAlgorithmProtocol, PopulationType>: EAAlgorithmDelegateProtocol where AlgorithmType.PopulationType == PopulationType, AlgorithmType.PopulationType.IndividualType == PopulationType.IndividualType {
    
    /**
     Callback of the delegate.
     */
    public var didFinishGeneration: ((AlgorithmType, UInt, PopulationType) -> Void)?
    
    /**
     Create a new algorithm delegate.
     */
    public init() {
        
    }
    
    public func eaAlgorithm(_ algorithm: AlgorithmType, didFinishGeneration generation: UInt, population: PopulationType) {
        didFinishGeneration?(algorithm, generation, population)
    }
    
}
