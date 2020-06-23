//
//  EAFitnessFunctionDomainValidationProtocol.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 18/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Abstract fitness function domain validation.
 */
public protocol EAFitnessFunctionDomainValidationProtocol {
    
    /// Generic Individual type where `IndividualType.DataType` equals to `DomainType.DataType`.
    associatedtype IndividualType: EAIndividualProtocol
    /// Generic Domain type where `DomainType.DataType` equals to `IndividualType.DataType`.
    associatedtype DomainType: EAFitnessFunctionDomainProtocol where DomainType.DataType == IndividualType.DataType
    
    /// Domains for each dimension.
    var domains: [DomainType] { get }
    
    /**
     Validate `individual`.
     
     - Parameter individual: Individual to be evaluated.
     - Parameter fitnessFunction: Fitness function which knows how to evaluate the `individual`.
     
     - Returns: Validated individual or nil if the `individual` is already valuated.
     */
    func validate<FitnessFunction: EAFitnessFunctionProtocol>(individual: IndividualType, fitnessFunction: FitnessFunction) -> IndividualType? where FitnessFunction.IndividualType == IndividualType
    
}
