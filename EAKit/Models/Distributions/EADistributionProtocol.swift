//
//  DistributionProtocol.swift
//  EAKit
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Distribution protocol for specific distribution such as: normal and uniform.
 */
public protocol EADistributionProtocol {
    
    /// Generic Data type of distribution.
    associatedtype DataType
    
    /**
     Generate random number.
     
     - Returns: Random number of `DataType`.
     */
    func random() -> DataType
    
}
