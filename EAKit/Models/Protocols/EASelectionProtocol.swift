//
//  EAGeneticAlgorithmSelectionProtocol.swift
//  EAKit
//
//  Created by Libor Polehna on 15/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public protocol EASelectionProtocol {
    
    associatedtype PopulationType: EAPopulationProtocol
    
    func createNewPopulation(population: PopulationType) -> PopulationType?
    mutating func prepare(population: PopulationType, context: EAContextProtocol?)
    func selectParents(population: PopulationType, count: Int, context: EAContextProtocol?) -> [PopulationType.IndividualType]
    
}
