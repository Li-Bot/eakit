//
//  UniformDistribution.swift
//  EAKit
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Uniform distribution.
*/
public struct EAUniformDistribution<DataType: EARandomProtocol>: EADistributionProtocol where DataType == DataType.T {
    
    /// Range define uniform distribution.
    public let range: ClosedRange<DataType>
    
    /**
     Uniform distribution defined by `ClosedRange<DataType>`.
    
     - Parameter range: Range of uniform distribution.
    */
    public init(range: ClosedRange<DataType>) {
        self.range = range
    }
    
    public func random() -> DataType {
        return DataType.random(in: range, using: &EAKit.randomNumberGenerator)
    }
    
}


/**
 Uniform distribution extension where `DataType` equals to `Hashable`.
*/
extension EAUniformDistribution where DataType: Hashable {
    
    /**
     Generate random numbers.
    
     - Parameter count: Number of random numbers.
     
     - Returns: Random numbers of `DataType`
    */
    public func random(count: UInt) -> [DataType] {
        var numbers = Set<DataType>()
        for _ in 0 ..< count {
            let randomValue = random(except: numbers)
            numbers.insert(randomValue)
        }
        return Array(numbers)
    }
    
    /**
     Generate random number except defined numbers.
    
     - Parameter except: Numbers which you do not want to generate.
     
     - Returns: Random number of `DataType`
    */
    public func random(except: Set<DataType>) -> DataType {
        while true {
            let value = random()
            if !except.contains(value) {
                return value
            }
        }
    }
    
}


/**
 Uniform distribution extension where `DataType` equals to `SignedInteger`.
*/
extension EAUniformDistribution where DataType: SignedInteger {
    
    /**
     Generate random number with minimum difference from one another.
    
     - Parameter count: Number of random numbers.
     - Parameter minimumDifference: Minimum difference from one another.
     
     - Returns: Random numbers of `DataType`.
    */
    public func random(count: UInt, minimumDifference: DataType? = nil) -> [DataType] {
        var numbers = Set<DataType>()
        while true {
            if numbers.count == count {
                break
            }
            
            let value = random()
            if !numbers.contains(value) {
                guard let minDiff = minimumDifference else {
                    numbers.insert(value)
                    continue
                }
                var wasFound = false
                for number in numbers {
                    if abs(value - number) < minDiff {
                        wasFound = true
                        break
                    }
                }
                if !wasFound {
                    numbers.insert(value)
                }
            }
        }
        return Array(numbers)
    }
    
}
