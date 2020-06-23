//
//  EAFitnessFunctionProtocol.swift
//  EAKit-iOS
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Abstract fitness function protocol.
 */
public protocol EAFitnessFunctionProtocol {
    
    /// Generic Individual type.
    associatedtype IndividualType: EAIndividualProtocol
    
    /// Dimension of n-dimensional problem.
    var dimension: Int { get }
    
    /**
     Evaluate fitness value of `individual`.
     
     - Parameter individual: Individual to be evaluated.
     
     - Returns: Fitness value of `individual`.
     */
    func evaluate(individual: IndividualType) -> Double
    /**
     Generate random individual defined by distribution.
     
     - Parameter type: Distribution type of new individual.
     
     - Returns: New Individual.
     */
    func getRandomIndividual(type: EADistributionType<IndividualType.DataType>) -> IndividualType
    /**
     Validate domains of `individual`. For example you can define boundaries of every dimension, invalid ranges, etc.
     
     - Parameter individual: Individual to be evaluated validated individual.
     
     - Returns: Validated individual or the same `individual` if the `individual` is already valid.
     */
    func validateDomains(individual: IndividualType) -> IndividualType
    
}
