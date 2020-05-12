//
//  EAGeneticAlgorithmSelectionProtocol.swift
//  EAKit
//
//  Created by Libor Polehna on 15/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public protocol EAGeneticAlgorithmSelectionProtocol {
    
    associatedtype PopulationType: EAPopulationProtocol
    
    func createNewPopulation(population: PopulationType) -> PopulationType?
    func selectParents(population: PopulationType) -> EAParentsGroup<PopulationType.IndividualType>
    
}
