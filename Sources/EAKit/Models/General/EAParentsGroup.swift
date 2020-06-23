//
//  EAParentsGroup.swift
//  EAKit
//
//  Created by Libor Polehna on 29/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Group for definition of parents. There has to always be two parents.
 */
public struct EAParentsGroup<IndividualType: EAIndividualProtocol> {
    
    /**
     You can access to parents by index, where negative or zero means first parent and greater or equal to 1 means second parent.
     
     - Parameter index: Index of the parent. Value should be in 0 or 1.
     
     - Returns: Individual defined by index.
     */
    public subscript(index: Int) -> IndividualType {
        if index <= 0 {
            return first
        }
        return second
    }
    
    /// First parent.
    public let first: IndividualType
    /// Second parent.
    public let second: IndividualType
    
}
