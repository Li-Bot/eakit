//
//  UniformDistribution.swift
//  EAKit
//
//  Created by Libor Polehna on 09/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EAUniformDistribution<DataType: EARandomProtocol>: EADistributionProtocol where DataType == DataType.T {
    
    public let range: ClosedRange<DataType>
    
    public init(range: ClosedRange<DataType>) {
        self.range = range
    }
    
    public func random() -> DataType {
        return DataType.random(in: range)
    }
    
}


extension EAUniformDistribution where DataType: Hashable {
    
    public func random(count: UInt) -> [DataType] {
        var numbers = Set<DataType>()
        for _ in 0 ..< count {
            let randomValue = random(except: numbers)
            numbers.insert(randomValue)
        }
        return Array(numbers)
    }
    
    public func random(except: Set<DataType>) -> DataType {
        while true {
            let value = random()
            if !except.contains(value) {
                return value
            }
        }
    }
    
}


extension EAUniformDistribution where DataType: SignedInteger {
    
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
