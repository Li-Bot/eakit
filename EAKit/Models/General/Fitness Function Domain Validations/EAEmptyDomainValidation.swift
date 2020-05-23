//
//  EAEmptyDomainValidation.swift
//  EAKit
//
//  Created by Libor Polehna on 18/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EAEmptyDomainValidation: EAFitnessFunctionDomainValidationProtocol {
    
    public func validate<FitnessFunction>(individual: FitnessFunction.IndividualType, fitnessFunction: FitnessFunction) -> FitnessFunction.IndividualType? where FitnessFunction : EAFitnessFunctionProtocol {
        return nil
    }
    
}
