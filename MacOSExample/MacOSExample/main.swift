//
//  main.swift
//  MacOSExample
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation
import EAKit


func hillClimbing() {
    let fitnessFunction = EAEasomFunction()
    var delegate = EAAlgorithmDelegate<EAHillClimbing<EAEasomFunction>>()
    delegate.didFinishGeneration = { algorithm, iterationIndex, population in
        print(population.bestIndividual?.fitness)
    }
    let parameters = try! EAHillClimbingParameters(populationCount: 200, generationsCount: 1000, fitnessFunction: fitnessFunction, deviation: 10.0, delegate: delegate)
    let hillClimbing = EAHillClimbing(parameters: parameters)
    let result = hillClimbing.run()
    print(result.bestPopulation.bestIndividual?.fitness)
    print(result.bestPopulation.bestIndividual?.data)
}


/*func geneticAlgorithm() {
    let fitnessFunction = EARosenbrockFunction()
    let selection = EAGARandomSelection<EARosenbrockFunction.PopulationType>()
    let crossover = EAGASinglePointCrossover<EARosenbrockFunction.PopulationType.IndividualType>()
    let mutation = EAGAFloatingNumericMutation<EARosenbrockFunction.PopulationType.IndividualType>(limit: 0.5, increment: (fitnessFunction.range.upperBound - fitnessFunction.range.lowerBound) * 0.001)
    var delegate = EAAlgorithmDelegate<EAGeneticAlgorithm<EARosenbrockFunction, EAGARandomSelection<EARosenbrockFunction.PopulationType>, EAGASinglePointCrossover<EARosenbrockFunction.PopulationType.IndividualType>, EAGAFloatingNumericMutation<EARosenbrockFunction.PopulationType.IndividualType>>>()
    delegate.didFinishGeneration = { algorithm, iterationIndex, population in
        print(population.bestIndividual.fitness)
    }
    let parameters = try! EAGeneticAlgorithmParameters(populationCount: 100, generationsCount: 1000, fitnessFunction: fitnessFunction, selection: selection, crossover: crossover, mutation: mutation, delegate: delegate)
    let genericAlgorithm = EAGeneticAlgorithm(parameters: parameters)
    let result = genericAlgorithm.run()
    print(result.bestPopulation.bestIndividual.fitness)
    print(result.bestPopulation.bestIndividual.data)
}*/


func geneticAlgorithm2() {
    let cities = [
        EATSPCity("A", [60.0, 200.0]),
        EATSPCity("B", [80.0, 200.0]),
        EATSPCity("C", [80.0, 180.0]),
        EATSPCity("D", [140.0, 180.0]),
        EATSPCity("E", [20.0, 160.0]),
        EATSPCity("F", [100.0, 160.0]),
        EATSPCity("G", [200.0, 160.0]),
        EATSPCity("H", [140.0, 140.0]),
        EATSPCity("I", [40.0, 120.0]),
        EATSPCity("J", [100.0, 120.0]),
        EATSPCity("K", [180.0, 100.0]),
        EATSPCity("L", [60.0, 80.0]),
        EATSPCity("M", [120.0, 80.0]),
        EATSPCity("N", [180.0, 60.0]),
        EATSPCity("O", [20.0, 40.0]),
        EATSPCity("P", [100.0, 40.0]),
        EATSPCity("Q", [200.0, 40.0]),
        EATSPCity("R", [20.0, 20.0]),
        EATSPCity("S", [60.0, 20.0]),
        EATSPCity("T", [160.0, 20.0])
    ]
    
    let fitnessFunction = EATSPFunction(cities: cities)
    let parameters = try! EAGeneticAlgorithmParameters(
            populationCount: 20,
            generationsCount: 2000,
            fitnessFunction: fitnessFunction,
            isElitism: true,
            selection: EAGARandomSelection(isElitism: true),
            crossover: EAGATSPTwoPointCrossover(threshold: 1.0),
            mutation: EAGASwapMutation(threshold: 0.9, count: 1),
            delegate: EAAlgorithmDelegate()
    )
    parameters.delegate?.didFinishGeneration = { algorithm, iterationIndex, population in
        print(population.bestIndividual?.fitness)
    }
    
    var success = 0
    let count = 1
    for _ in 0 ..< count {
        let genericAlgorithm = EAGeneticAlgorithm(parameters: parameters)
        let result = genericAlgorithm.run()
        if result.bestPopulation.bestIndividual!.fitness < 857.0 {
            success += 1
        }
        print(result.bestPopulation.bestIndividual?.fitness)
        print(result.bestPopulation.bestIndividual?.data)
    }
    print(Double(success) / Double(count))
}


func geneticAlgorithm3() {
    let fitnessFunction = EATextFunction(text: /*"Dubai, United Arab Emirates."*/ "SKOUMAL Studio s.r.o. by Libor Polehna")
    let parameters = try! EAGeneticAlgorithmParameters(
            populationCount: 20,
            generationsCount: 2000,
            fitnessFunction: fitnessFunction,
            isElitism: true,
            selection: EAGATournamentSelection(isElitism: true, tournamentSize: 6),
            crossover: EAGAKPointCrossover(threshold: 1.0, k: 2),
            mutation: EAGAReplacementMutation(threshold: 1.0, count: 1, set: fitnessFunction.characters),
            delegate: EAAlgorithmDelegate()
    )
    parameters.delegate?.didFinishGeneration = { algorithm, iterationIndex, population in
        //print(population.bestIndividual?.fitness)
        if population.bestIndividual!.fitness == 0 {
            print(iterationIndex)
        }
        print(population.bestIndividual?.text)
    }
    
    let genericAlgorithm = EAGeneticAlgorithm(parameters: parameters)
    let result = genericAlgorithm.run()
    print(result.bestPopulation.bestIndividual?.fitness)
    print(result.bestPopulation.bestIndividual?.text)
}


//hillClimbing()
//geneticAlgorithm2()
geneticAlgorithm3()
