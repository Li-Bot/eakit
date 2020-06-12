//
//  FakeRandomNumberGenerator.swift
//  EAKit
//
//  Created by Libor Polehna on 09/06/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


struct FakeRandomNumberGenerator: RandomNumberGenerator {
    
    init(seed: Int = 2017) {
        srand48(seed)
    }

    public mutating func next() -> UInt64 {
        return nextValue()
    }

    public mutating func next<T>() -> T where T : FixedWidthInteger, T : UnsignedInteger {
        return T(nextValue())
    }

    public mutating func next<T>(upperBound: T) -> T where T : FixedWidthInteger, T : UnsignedInteger {
        fatalError("Not implemented")
    }
    
    private func nextValue() -> UInt64 {
        return UInt64(round(drand48() * Double(UInt64.max)))
    }
    
}
