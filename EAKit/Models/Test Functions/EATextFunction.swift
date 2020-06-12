//
//  EATextFunction.swift
//  EAKit
//
//  Created by Libor Polehna on 04/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 General Fitness Function for Text.
 */
public class EATextFunction: EAFitnessFunctionProtocol {

    public let dimension: Int
    /// Desired Text.
    public let text: String
    /// Allowed characters.
    public let charactersSet: CharacterSet
    
    /// Array of Character from CharacterSet.
    public lazy var characters: [Character] = {
        return getCharacters()
    }()
    
    /**
     Create a new text fitness function.
     
     - Parameter text: Desired text.
     - Parameter charactersSet: Allowed characters.
     */
    public init(text: String, charactersSet: CharacterSet? = nil) {
        dimension = text.count
        self.text = text
        if let charsSet = charactersSet {
            self.charactersSet = charsSet
        } else {
            var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYUZ"
            alphabet += alphabet.lowercased()
            alphabet += "&,-/ '$%^*()@#!\"[]{}_?:|<>~+=."
            self.charactersSet = charactersSet ?? CharacterSet(charactersIn: alphabet)
        }
    }
    
    public func evaluate(individual: EACharacterIndividual) -> Double {
        var fitness = 0.0
        
        for (index, char) in individual.data.enumerated() {
            let textIndex = text.index(text.startIndex, offsetBy: index)
            if char != text[textIndex] {
                fitness += 1.0
            }
        }

        return fitness
    }
    
    public func getRandomIndividual(type: EADistributionType<EACharacterIndividual.DataType>) -> EACharacterIndividual {
        let individual = EACharacterIndividual()
        individual.data = Array(characters.shuffled(using: &EAKit.randomNumberGenerator).prefix(upTo: dimension))
        individual.fitness = evaluate(individual: individual)
        return individual
    }
    
    public func validateDomains(individual: EAIndividual<Character>) -> EAIndividual<Character> {
        return individual
    }
    
    /**
     Convert CharacterSet to Array of Character.
     
     - Returns: Array of Character.
     */
    private func getCharacters() -> [Character] {
        var chars: [Character] = []
        for plane in Unicode.UTF8.CodeUnit.min ... 16 where charactersSet.hasMember(inPlane: plane) {
            for unicode in Unicode.UTF32.CodeUnit(plane) << 16 ..< Unicode.UTF32.CodeUnit(plane + 1) << 16 {
                if let uniChar = UnicodeScalar(unicode), charactersSet.contains(uniChar) {
                    chars.append(Character(uniChar))
                }
            }
        }
        return chars
    }
    
}
