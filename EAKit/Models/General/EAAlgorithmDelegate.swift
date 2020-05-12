//
//  EAAlgorithmDelegate.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EAAlgorithmDelegate<AlgorithmType: EAAlgorithmProtocol>: EAAlgorithmDelegateProtocol {
    
    public var didFinishGeneration: ((AlgorithmType, UInt, AlgorithmType.FitnessFunctionType.PopulationType) -> Void)?
    
    public init() {
        
    }
    
    public func eaAlgorithm(_ algorithm: AlgorithmType, didFinishGeneration generation: UInt, population: AlgorithmType.FitnessFunctionType.PopulationType) {
        didFinishGeneration?(algorithm, generation, population)
    }
    
}
