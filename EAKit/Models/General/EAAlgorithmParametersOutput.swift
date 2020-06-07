//
//  EAAlgorithmParametersOutput.swift
//  EAKit
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Algorithm parameters output.
 */
public struct EAAlgorithmParametersOutput {
    
    /// Default output with deafult values.
    public static let defaultOutput = EAAlgorithmParametersOutput(saveProgress: false)
    
    /// If true the progress will be kept, otherwise only the best result will be kept.
    public let saveProgress: Bool
    
    /**
     Create a new algorithm parameters output.
     
     - Parameter saveProgress: If true the progress will be kept, otherwise only the best result will be kept.
     */
    public init(saveProgress: Bool) {
        self.saveProgress = saveProgress
    }
    
}
