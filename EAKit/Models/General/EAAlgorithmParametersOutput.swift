//
//  EAAlgorithmParametersOutput.swift
//  EAKit
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EAAlgorithmParametersOutput {
    
    public static let defaultOutput = EAAlgorithmParametersOutput(saveProgress: false)
    
    public let saveProgress: Bool
    
}
