//
//  EAFitnessFunctionDomainProtocol.swift
//  EAKit
//
//  Created by Libor Polehna on 26/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Abstract fitness function domain protocol.
 */
public protocol EAFitnessFunctionDomainProtocol {
    
    /// Generic Data type.
    associatedtype DataType
    
    /**
     Validate `value`.
     
     - Parameter value: Value to be validated.
     
     - Returns: Validated value or nil if value is already valid. 
     */
    func validate(value: DataType) -> DataType?
    
}
