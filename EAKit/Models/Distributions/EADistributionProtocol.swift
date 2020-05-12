//
//  DistributionProtocol.swift
//  EAKit
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public protocol EADistributionProtocol {
    
    associatedtype DataType
    
    func random() -> DataType
    
}
