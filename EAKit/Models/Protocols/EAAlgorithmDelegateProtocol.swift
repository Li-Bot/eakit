//
//  EAAlgorithmDelegate.swift
//  EAKit
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public protocol EAAlgorithmDelegateProtocol {
    
    associatedtype AlgorithmType: EAAlgorithmProtocol
    
    func eaAlgorithm(_ algorithm: AlgorithmType, didFinishGeneration generation: UInt, population:  AlgorithmType.FitnessFunctionType.PopulationType)
    
}
