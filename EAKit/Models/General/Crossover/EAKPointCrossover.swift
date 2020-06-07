//
//  EAGAKPointCrossover.swift
//  EAKit
//
//  Created by Libor Polehna on 19/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 General k-point crossover where an individual is crossed at k points.
 */
public class EAKPointCrossover<IndividualType: EAIndividualProtocol>: EACrossoverProtocol {
    
    public let threshold: Double
    /// Number of crosspoints.
    public final let k: UInt
    
    /**
     Create a new k-point crossover.
     
     - Parameter threshold: Treshold which defines if crossover will be performed or not. This parameter has to be in <0.0;1.0>.
     - Parameter k: Number of crosspoints.
     */
    public init(threshold: Double, k: UInt) {
        self.threshold = threshold
        self.k = k
    }
    
    public final func cross(first: IndividualType, second: IndividualType) -> [IndividualType] {
        let size = first.data.count
        let range = size > 2 ? 1 ... (size - 2) : 1 ... 1
        let uniformDistribution = EAUniformDistribution(range: range)
        let indexes = uniformDistribution.random(count: k, minimumDifference: 1).sorted()
        var firstIndividual = IndividualType()
        var secondIndividual = IndividualType()
        
        var crossoverIndex = 0
        for dataIndex in 0 ..< size {
            if dataIndex == indexes[crossoverIndex] {
                if crossoverIndex != indexes.count - 1 {
                    crossoverIndex += 1
                }
            }
            if dataIndex < indexes[crossoverIndex] {
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
