//
//  DistributionType.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 10/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Generic statistical distribution type.
 */
public enum EADistributionType<DataType> {
    
    /// Uniform distribution.
    case uniform
    
    /**
     Normal distribution defined by `μ` and `σ`.
     
     - μ: Input mean of distribution.
     - σ: Input variance of distribution.
     */
    case normal(μ: [DataType], σ: DataType)
    
}
