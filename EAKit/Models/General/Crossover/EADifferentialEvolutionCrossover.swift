//
//  EADifferentialEvolutionCrossover.swift
//  EAKit
//
//  Created by Libor Polehna on 25/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Differential evolution crossover used in the differential evolution algorithm.
 */
public class EADifferentialEvolutionCrossover<IndividualType: EAIndividualProtocol>: EACrossoverProtocol {
    
    public let threshold: Double
    
    /**
     Create a new differential evolution crossover.
    
     - Parameter cr: Treshold which defines if crossover will be performed or not. This parameter has to be in <0.0;1.0>.
    */
    public init(cr: Double) {
        threshold = cr
    }
    
    public final func cross(first: IndividualType, second: IndividualType) -> [IndividualType] {
        let size = first.data.count
        let uniformDistribution = EAUniformDistribution(range: 0.0 ... 1.0)
        var firstIndividual = IndividualType()
        var secondIndividual = IndividualType()
        
        for dataIndex in 0 ..< size {
            if uniformDistribution.random() < threshold {
                firstIndividual.data.append(second.data[dataIndex])
                secondIndividual.data.append(first.data[dataIndex])
            } else {
                firstIndividual.data.append(first.data[dataIndex])
                secondIndividual.data.append(second.data[dataIndex])
            }
        }
        
        return [firstIndividual, secondIndividual]
    }
    
}
