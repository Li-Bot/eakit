//
//  EAAlgorithmDelegate.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EAAlgorithmDelegate<AlgorithmType: EAAlgorithmProtocol, PopulationType>: EAAlgorithmDelegateProtocol where AlgorithmType.PopulationType == PopulationType, AlgorithmType.PopulationType.IndividualType == PopulationType.IndividualType {
    
    public var didFinishGeneration: ((AlgorithmType, UInt, PopulationType) -> Void)?
    
    public init() {
        
    }
    
    public func eaAlgorithm(_ algorithm: AlgorithmType, didFinishGeneration generation: UInt, population: PopulationType) {
        didFinishGeneration?(algorithm, generation, population)
    }
    
}
