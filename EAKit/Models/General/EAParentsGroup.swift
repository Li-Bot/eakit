//
//  EAParentsGroup.swift
//  EAKit
//
//  Created by Libor Polehna on 29/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EAParentsGroup<IndividualType: EAIndividualProtocol> {
    
    public subscript(index: Int) -> IndividualType {
        if index <= 0 {
            return first
        }
        return second
    }
    
    public let first: IndividualType
    public let second: IndividualType
    
}
