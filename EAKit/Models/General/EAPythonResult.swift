//
//  EAPythonResult.swift
//  EAKit
//
//  Created by Libor Polehna on 22/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EAPythonResult<Result: EAAlgorithmResult<PopulationType>, PopulationType: EAPopulationProtocol> where PopulationType.IndividualType.DataType: CustomStringConvertible {
    
    public let result: EAAlgorithmResult<PopulationType>
    public let name: String
    
    public init(result: EAAlgorithmResult<PopulationType>, name: String) {
        self.result = result
        self.name = name
    }
    
    public func save() throws {
        let fileName = "\(name).txt"
        let fileUrl = URL(fileURLWithPath: fileName)
        FileManager.default.createFile(atPath: fileUrl.relativePath, contents: Data(), attributes: nil)
        let fileWriter = try FileHandle(forWritingTo: fileUrl)
        
        for (pIndex, population) in result.populations.enumerated() {
            let individuals = [result.bestPopulation.bestIndividual!] + population.individuals
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
        
        try fileWriter.close()
    }
    
}
