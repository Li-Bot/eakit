//
//  EAIndividualProtocol.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public protocol EAIndividualProtocol {
    
    associatedtype DataType
    
    init()
    
    var fitness: Double { get set }
    var data: [DataType] { get set }
    
}
