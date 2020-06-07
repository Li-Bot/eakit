//
//  EAGAUniformCrossover.swift
//  EAKit
//
//  Created by Libor Polehna on 19/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Uniform crossover.
*/
public struct EAUniformCrossover<IndividualType: EAIndividualProtocol>: EACrossoverProtocol {
    
    public let threshold: Double
    
    /**
     Create a new uniform crossover.
     
     - Parameter threshold: Treshold which defines if crossover will be performed or not. This parameter has to be in <0.0;1.0>.
     */
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
