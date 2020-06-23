//
//  EAPythonResult.swift
//  EAKit
//
//  Created by Libor Polehna on 22/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


/**
 Save result of an algorithm as a file and read it in the python.
 */
public final class EAPythonResult<Result: EAAlgorithmResult<PopulationType>, PopulationType: EAPopulationProtocol> where PopulationType.IndividualType.DataType: CustomStringConvertible {
    
    /// Result of an algorithm.
    public let result: EAAlgorithmResult<PopulationType>
    /// Name of the file.
    public let name: String
    
    /**
     Create a new python result.
     
     - Parameter result: Result of an algorithm.
     - Parameter name: Name of the file.
     */
    public init(result: EAAlgorithmResult<PopulationType>, name: String) {
        self.result = result
        self.name = name
    }
    
    /**
     Save data to disk.
     
     - Throws: If saving failed the method throws an error.
     */
    public func save(useGlobalBest: Bool = true) throws {
        let fileName = "\(name).txt"
        let fileUrl = URL(fileURLWithPath: fileName)
        FileManager.default.createFile(atPath: fileUrl.relativePath, contents: Data(), attributes: nil)
        let fileWriter = try FileHandle(forWritingTo: fileUrl)
        
        for (pIndex, population) in result.populations.enumerated() {
            fileWriter.write("\(population.bestIndividual!.fitness)#".data(using: .utf8)!)
            let individuals = [useGlobalBest ? result.bestPopulation.bestIndividual! : population.bestIndividual!] + population.individuals
            for (iIndex, individual) in individuals.enumerated() {
                for (dIndex, data) in individual.data.enumerated() {
                    guard let stringData = "\(data)".data(using: .utf8) else {
                        continue
                    }
                    fileWriter.write(stringData)
                    if dIndex != individual.data.count - 1 {
                        fileWriter.write(";".data(using: .utf8)!)
                    }
                }
                if iIndex != population.size {
                    fileWriter.write("#".data(using: .utf8)!)
                }
            }
            if pIndex != result.populations.count - 1 {
                fileWriter.write("\n".data(using: .utf8)!)
            }
        }
        
        if #available(OSX 10.15, iOS 13, *) {
            try fileWriter.close()
        } else {
            fileWriter.closeFile()
        }
    }
    
}
