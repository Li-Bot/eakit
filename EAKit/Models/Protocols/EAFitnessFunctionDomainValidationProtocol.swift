//
//  EAFitnessFunctionDomainValidationProtocol.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 18/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public protocol EAFitnessFunctionDomainValidationProtocol {
    
    func validate<FitnessFunction: EAFitnessFunctionProtocol>(individual: FitnessFunction.IndividualType, fitnessFunction: FitnessFunction) -> FitnessFunction.IndividualType?
    
}
