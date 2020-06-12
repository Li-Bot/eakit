//
//  EARandomProtocol.swift
//  EAKit
//
//  Created by Libor Polehna on 17/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public protocol EARandomProtocol {
    
    associatedtype T: Comparable
    
    static func random(in range: ClosedRange<T>) -> T
    static func random<R>(in range: ClosedRange<T>, using generator: inout R) -> T where R: RandomNumberGenerator
    
}

extension Double: EARandomProtocol {}
extension Float: EARandomProtocol {}
extension Int: EARandomProtocol {}
extension UInt: EARandomProtocol {}
