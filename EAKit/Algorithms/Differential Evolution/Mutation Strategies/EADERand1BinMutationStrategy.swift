//
//  EADERand1BinMutationStrategy.swift
//  EAKit
//
//  Created by Libor Polehna on 24/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 DERand1Bin Mutation Strategy
 */
public struct EADERand1BinMutationStrategy<IndividualType: EAIndividualProtocol> : EADifferentialEvolutionMutationStrategyProtocol where IndividualType.DataType: Numeric {
    
    public var f: IndividualType.DataType
    public var λ: IndividualType.DataType
    
    public let parentsCount: Int = 3
    
    /**
     Create a new DERand1Bin mutation strategy.
     
     - Parameter f: Mutation constant F.
     - Parameter λ: Mutation constant λ.
     */
    public init(f: IndividualType.DataType, λ: IndividualType.DataType) {
        self.f = f
        self.λ = λ
    }
    
    public func mutate(activeIndividual: IndividualType, bestIndividual: IndividualType, individuals: [IndividualType], context: EADifferentialEvolutionContext) -> IndividualType {
        var offspring = IndividualType()
        
        for index in 0 ..< activeIndividual.data.count {
            let value = individuals[2].data[index] + f * (individuals[0].data[index] - individuals[1].data[index])
            offspring.data.append(value)
        }
        
        return offspring
    }
    
}
