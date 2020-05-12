//
//  DistributionType.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 10/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public enum EADistributionType<DataType> {
    
    case uniform
    case normal(μ: [DataType], σ: DataType)
    
}
