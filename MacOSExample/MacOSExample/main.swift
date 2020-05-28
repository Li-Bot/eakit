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
    var delegate = EAAlgorithmDelegate<EAHillClimbing<EAEasomFunction>, EAPopulation<EADoubleIndividual>>()
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
            selection: EARandomSelection(isElitism: true),
            crossover: EAGATSPTwoPointCrossover(threshold: 1.0),
            mutation: EASwapMutation(threshold: 0.9, count: 1),
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
            selection: EARouletteSelection(isElitism: true),
            crossover: EAKPointCrossover(threshold: 1.0, k: 2),
            mutation: EAReplacementMutation(threshold: 1.0, count: 1, set: fitnessFunction.characters),
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


func evolutionaryAlgorithm() {
    let fitnessFunction = EARastriginFunction()
    let configuration = try! EAEvolutionaryStrategyConfiguration(µ: 20, ρ: 1, selectionStrategy: .plus, λ: 20)
    let parameters = try! EAEvolutionaryStrategyParameters(
        generationsCount: 2000,
        configuration: configuration,
        fitnessFunction: fitnessFunction,
        selection: EARandomSelection(),
        recombination: EAESIntermadiateRecombination(),
        mutation: EAESNormalMutation(threshold: 1.0, σ: 0.5),
        output: .defaultOutput,
        delegate: EAAlgorithmDelegate()
    )
    
    parameters.delegate?.didFinishGeneration = { algorithm, iterationIndex, population in
        print(population.bestIndividual?.fitness)
    }
    
    let evolutionaryStrategy = EAEvolutionaryStrategy(parameters: parameters)
    let result = evolutionaryStrategy.run()
    print(result.bestPopulation.bestIndividual?.fitness)
    print(result.bestPopulation.bestIndividual?.data)
}


func particleSwarm() {
    let parameters = try! EAParticleSwarmParameters(
        particlesCount: 10,
        iterationsCount: 50,
        velocity: EAParticleSwarmVelocity(maximum: EARastriginFunction().distance / 20.0),
        learning: EAParticleSwarmLearning.defaultLearning,
        inertiaWeight: EAParticleSwarmInertiaWeight.defaultInertiaWeight,
        fitnessFunction: EARastriginFunction(),
        output: EAAlgorithmParametersOutput(saveProgress: true),
        delegate: EAAlgorithmDelegate()
    )
    
    parameters.delegate?.didFinishGeneration = { algorithm, iterationIndex, population in
        print(population.bestIndividual?.fitness)
    }
    
    let particleSwarm = EAParticleSwarm(parameters: parameters)
    let result = particleSwarm.run()
    print(result.bestPopulation.bestIndividual?.fitness)
    print(result.bestPopulation.bestIndividual?.data)
    
    let pythonResult = EAPythonResult(result: result, name: "EARastriginFunction")
    do {
        try pythonResult.save()
    } catch {
        debugPrint(error)
    }
}


func differentialEvolution() {
    let parameters = try! EADifferentialEvolutionParameters(
        populationCount: 10,
        generationsCount: 20,
        selection: EARandomSelection(),
        mutationStrategy: EADERand1BinMutationStrategy(f: 0.5, λ: 0.5),
        crossover: EADifferentialEvolutionCrossover(cr: 0.9),
        fitnessFunction: EARastriginFunction(),
        output: EAAlgorithmParametersOutput(saveProgress: true),
        delegate: EAAlgorithmDelegate()
    )
    
    parameters.delegate?.didFinishGeneration = { algorithm, iterationIndex, population in
        print(population.bestIndividual?.fitness)
    }
    
    let differentialEvolution = EADifferentialEvolution(parameters: parameters)
    let result = differentialEvolution.run()
    print(result.bestPopulation.bestIndividual?.fitness)
    print(result.bestPopulation.bestIndividual?.data)
    
    let pythonResult = EAPythonResult(result: result, name: "EARastriginFunction")
    do {
        try pythonResult.save()
    } catch {
        debugPrint(error)
    }
}

//hillClimbing()
//geneticAlgorithm2()
//geneticAlgorithm3()
//evolutionaryAlgorithm()
//particleSwarm()
differentialEvolution()
