//
//  EAFitnessFunctionDomainProtocol.swift
//  EAKit
//
//  Created by Libor Polehna on 26/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public protocol EAFitnessFunctionDomainProtocol {
    
    associatedtype DataType
    
    func validate(value: DataType) -> DataType?
    
}
