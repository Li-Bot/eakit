//
//  EARangeDomain.swift
//  EAKit
//
//  Created by Libor Polehna on 27/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EARangeDomain<DataType: Comparable>: EAFitnessFunctionDomainProtocol {
    
    private let range: ClosedRange<DataType>
    
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
