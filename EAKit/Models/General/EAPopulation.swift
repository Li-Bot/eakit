//
//  EAPopulation.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EAPopulation<IndividualType: EAIndividualProtocol>: EAPopulationProtocol {
    
    public var bestIndividual: IndividualType? {
        if let index = bestIndividualIndex {
            return individuals[index]
        }
        return nil
    }
    
    public private(set) var individuals: [IndividualType]
    
    private var bestIndividualIndex: Int?
    
    public required init(individuals: [IndividualType]) {
        self.individuals = []
        bestIndividualIndex = nil
        append(individuals: individuals)
    }
    
    public func append(individual: IndividualType) {
        individuals.append(individual)
        if bestIndividual == nil || individual.fitness < bestIndividual!.fitness {
            bestIndividualIndex = individuals.count - 1
        }
    }
    
    public func append(individuals: [IndividualType]) {
        self.individuals.append(contentsOf: individuals)
        for (index, individual) in individuals.enumerated() {
            if bestIndividual == nil || individual.fitness < bestIndividual!.fitness {
                bestIndividualIndex = self.individuals.count - individuals.count + index
            }
        }
    }
    
}
