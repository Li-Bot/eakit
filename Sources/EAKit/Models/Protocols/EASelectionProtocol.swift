//
//  EAGeneticAlgorithmSelectionProtocol.swift
//  EAKit
//
//  Created by Libor Polehna on 15/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Abstract selection protocol.
 */
public protocol EASelectionProtocol {
    
    /// Generic Population type.
    associatedtype PopulationType: EAPopulationProtocol
    
    /**
     Create a new population based on the current `population`. You can use it for elitism.
     
     - Parameter population: Current population.
     
     - Returns: New population or nil if there is no need of privileges.
     */
    func createNewPopulation(population: PopulationType) -> PopulationType?
    /**
     This method is called before every new generation. You can use it for preprocessing any data of the current `population`, which you will be needed for selection later.
     
     - Parameter population: Current population.
     - Parameter context: Additional metadata.
     */
    mutating func prepare(population: PopulationType, context: EAContextProtocol?)
    /**
     Select desired number of parents based on the curent `population`.
     
     - Parameter population: Current population.
     - Parameter count: Number of parents.
     - Parameter context: Additional metadata.
     
     - Returns: Selected parents.
     */
    func selectParents(population: PopulationType, count: Int, context: EAContextProtocol?) -> [PopulationType.IndividualType]
    
}
