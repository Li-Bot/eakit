//
//  EARandomNumberGeneratorWrapper.swift
//  EAKit
//
//  Created by Libor Polehna on 09/06/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public struct EARandomNumberGeneratorWrapper: RandomNumberGenerator {
    
    private var generator: RandomNumberGenerator
    
    init(generator: RandomNumberGenerator = SystemRandomNumberGenerator()) {
        self.generator = generator
    }

    public mutating func next() -> UInt64 {
        return generator.next()
    }

    public mutating func next<T>() -> T where T : FixedWidthInteger, T : UnsignedInteger {
        return generator.next()
    }

    public mutating func next<T>(upperBound: T) -> T where T : FixedWidthInteger, T : UnsignedInteger {
        return self.generator.next(upperBound: upperBound)
    }
    
}
