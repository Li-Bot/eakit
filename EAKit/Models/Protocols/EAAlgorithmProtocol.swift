//
//  EAAlgorithm.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public protocol EAAlgorithmProtocol {
    
    associatedtype FitnessFunctionType: EAFitnessFunctionProtocol
    associatedtype PopulationType: EAPopulationProtocol 
    
    func run() -> EAAlgorithmResult<PopulationType>
    
}
