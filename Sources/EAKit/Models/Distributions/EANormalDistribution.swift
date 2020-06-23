//
//  NormalDistribution.swift
//  EAKit
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Normal distribution defined by `μ` and `σ`.
*/
public struct EANormalDistribution<DataType>: EADistributionProtocol {
    
    /// Mean of distribution.
    public let μ: DataType
    /// Variance of distribution.
    public let σ: DataType
    
    /**
     Normal distribution defined by `μ` and `σ`.
    
     - Parameter μ: Input mean of distribution.
     - Parameter σ: Input variance of distribution.
    */
    public init(μ: DataType, σ: DataType) {
        self.μ = μ
        self.σ = σ
    }
    
    public func random() -> DataType {
        fatalError("'random' has not been implemented yet")
    }
    
}


/**
 Normal distribution extension when `DataType` equal to `Double`.
*/
extension EANormalDistribution where DataType == Double {
    
    /**
     Generate random number.
    
     - Returns: Random number of `DataType`
    */
    public func random() -> DataType {
        let x1 = DataType.random(in: 0.0 ... 1.0, using: &EAKit.randomNumberGenerator)
        let x2 = DataType.random(in: 0.0 ... 1.0, using: &EAKit.randomNumberGenerator)
        let z1 = sqrt(-2.0 * log(x1)) * cos(2.0 * Double.pi * x2)
        return z1 * σ + μ
    }
    
}
