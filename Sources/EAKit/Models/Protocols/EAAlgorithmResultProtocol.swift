//
//  EAAlgorithmResultProtocol.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Abstract evolutionary algorithm result.
 */
public protocol EAAlgorithmResultProtocol {
    
    /// Generic Population type.
    associatedtype PopulationType: EAPopulationProtocol
    
    /// The best population of lifetime.
    var bestPopulation: PopulationType { get }
    /// All populations which have been made.
    var populations: [PopulationType] { get }
    
    /**
     Create a new algorithm result.
     
     - Parameter population: Initial popualtion.
     */
    init(population: PopulationType)
    
    /**
     Add new population to the result.
     
     - Parameter keepBestOnly: If true only the best population will be kept in the memory, otherwise all populations will be kept.
     */
    func append(population: PopulationType, keepBestOnly: Bool)
    /**
     Remove all populations and set `population` to be the only population in the result.
     
     - Parameter population: New initial population.
     */
    func set(population: PopulationType)
    
}
