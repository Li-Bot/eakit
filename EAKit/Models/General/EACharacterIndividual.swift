//
//  EACharacterIndividual.swift
//  EAKit
//
//  Created by Libor Polehna on 04/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

public typealias EACharacterIndividual = EAIndividual<Character>


public extension EACharacterIndividual {
    
    var text: String {
        return String(data)
    }
    
}
