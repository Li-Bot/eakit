//
//  EAFitnessFunctionDomainValidationProtocol.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 18/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public protocol EAFitnessFunctionDomainValidationProtocol {
    
    associatedtype IndividualType: EAIndividualProtocol
    associatedtype DomainType: EAFitnessFunctionDomainProtocol where DomainType.DataType == IndividualType.DataType
    
    var domains: [DomainType] { get }
    
    func validate<FitnessFunction: EAFitnessFunctionProtocol>(individual: IndividualType, fitnessFunction: FitnessFunction) -> IndividualType? where FitnessFunction.IndividualType == IndividualType
    
}
