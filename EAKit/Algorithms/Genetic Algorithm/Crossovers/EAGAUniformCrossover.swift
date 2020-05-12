//
//  EAGAUniformCrossover.swift
//  EAKit
//
//  Created by Libor Polehna on 19/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EAGAUniformCrossover<IndividualType: EAIndividualProtocol>: EAGeneticAlgorithmCrossoverProtocol {
    
    public let threshold: Double
    
    public init(threshold: Double) {
        self.threshold = threshold
    }
        
    public func cross(first: IndividualType, second: IndividualType) -> [IndividualType] {
        let size = first.data.count
        let uniformDistribution = EAUniformDistribution(range: 0.0 ... 1.0)
        var firstIndividual = IndividualType()
        var secondIndividual = IndividualType()
        
        for dataIndex in 0 ..< size {
            if uniformDistribution.random() <= 0.5 {
                firstIndividual.data.append(first.data[dataIndex])
                secondIndividual.data.append(second.data[dataIndex])
            } else {
                firstIndividual.data.append(second.data[dataIndex])
                secondIndividual.data.append(first.data[dataIndex])
            }
        }
        
        return [firstIndividual, secondIndividual]
    }
    
}
