//
//  EACharacterIndividual.swift
//  EAKit
//
//  Created by Libor Polehna on 04/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//


/// Individual of Character data type.
public typealias EACharacterIndividual = EAIndividual<Character>



public extension EACharacterIndividual {
    
    /// Human readable text of individuals's data.
    var text: String {
        return String(data)
    }
    
}
