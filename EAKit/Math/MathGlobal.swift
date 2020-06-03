//
//  MathGlobal.swift
//  EAKit
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Square root of `value`. In other words second power of input `value`.
 
 - Parameter value: The input number.
 - Returns: Square root of `value`.
 */
@inline(__always)
internal func pow2<T: Numeric>(_ value: T) -> T {
    return value * value
}
