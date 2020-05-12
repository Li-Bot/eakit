//
//  NormalDistribution.swift
//  EAKit
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EANormalDistribution<DataType>: EADistributionProtocol {
    
    public let μ: DataType
    public let σ: DataType
    
    public init(μ: DataType, σ: DataType) {
        self.μ = μ
        self.σ = σ
    }
    
    public func random() -> DataType {
        fatalError("'random' has not been implemented yet")
    }
    
}


extension EANormalDistribution where DataType == Double {
    
    public func random() -> DataType {
        let x1 = DataType.random(in: 0.0 ... 1.0)
        let x2 = DataType.random(in: 0.0 ... 1.0)
        let z1 = sqrt(-2.0 * log(x1)) * cos(2.0 * Double.pi * x2)
        return z1 * σ + μ
    }
    
}
