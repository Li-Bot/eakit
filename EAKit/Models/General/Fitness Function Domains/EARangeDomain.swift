//
//  EARangeDomain.swift
//  EAKit
//
//  Created by Libor Polehna on 27/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 General fitness function domain defined by range.
 */
public struct EARangeDomain<DataType: Comparable>: EAFitnessFunctionDomainProtocol {
    
    /// Closed range of the domain.
    private let range: ClosedRange<DataType>
    
    /**
     Create a new range domain.
     
     - Parameter range: Closed range of the domain.
     */
    public init(range: ClosedRange<DataType>) {
        self.range = range
    }
    
    public func validate(value: DataType) -> DataType? {
        if value > range.upperBound {
            return range.upperBound
        } else if value < range.lowerBound {
            return range.lowerBound
        }
        return nil
    }
    
}
