//
//  EAAlgorithmResultProtocol.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public protocol EAAlgorithmResultProtocol {
    
    associatedtype PopulationType: EAPopulationProtocol
    
    var bestPopulation: PopulationType { get }
    var populations: [PopulationType] { get }
    
    init(population: PopulationType)
    
    func append(population: PopulationType, keepBestOnly: Bool)
    func set(population: PopulationType)
    
}
