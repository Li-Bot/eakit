//
//  main.swift
//  MacOSExample
//
//  Created by Libor Polehna on 11/04/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation
import EAKit


func hillClimbingAL() {
    let parameters = try! EAHillClimbingParameters(
        populationCount: 20,
        generationsCount: 101,
        fitnessFunction: EAAckleyFunction(),
        deviation: 0.5,
        output: EAAlgorithmParametersOutput(saveProgress: true),
        delegate: EAAlgorithmDelegate()
    )
    parameters.delegate?.didFinishGeneration = { algorithm, iterationIndex, population in
        print(population.bestIndividual!.fitness)
    }
    let hillClimbing = EAHillClimbing(parameters: parameters)
    let result = hillClimbing.run()
    print(result.bestPopulation.bestIndividual!.fitness)
    print(result.bestPopulation.bestIndividual!.data)
}

func geneticAlgorithmTSP() {
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
            crossover: EATSPTwoPointCrossover(threshold: 1.0),
            mutation: EASwapMutation(threshold: 0.9, count: 1),
            output: EAAlgorithmParametersOutput(saveProgress: true),
            delegate: EAAlgorithmDelegate()
    )
    parameters.delegate?.didFinishGeneration = { algorithm, iterationIndex, population in
        print(population.bestIndividual!.fitness)
    }
    let algorithm = EAGeneticAlgorithm(parameters: parameters)
    let result = algorithm.run()
    print(result.bestPopulation.bestIndividual!.fitness)
    print(result.bestPopulation.bestIndividual!.data)
}


func geneticAlgorithmText() {
    let text = "SKOUMAL Studiosophisticated simplicity" //"Evolutionary Algorithms written in Swift"
    let fitnessFunction = EATextFunction(text: text)
    let ff2 = EATextFunction(text: text, charactersSet: CharacterSet(charactersIn: text))
    let parameters = try! EAGeneticAlgorithmParameters(
            populationCount: 20,
            generationsCount: 1000,
            fitnessFunction: fitnessFunction,
            isElitism: true,
            selection: EARouletteSelection(isElitism: true),
            crossover: EAKPointCrossover(threshold: 1.0, k: 3),
            mutation: EAReplacementMutation(threshold: 1.0, count: 1, set: ff2.characters),
            output: EAAlgorithmParametersOutput(saveProgress: true),
            delegate: EAAlgorithmDelegate()
    )
    parameters.delegate?.didFinishGeneration = { algorithm, iterationIndex, population in
        print(population.bestIndividual!.text)
        if population.bestIndividual!.fitness == 0.0 {
            print(iterationIndex)
        }
    }
    let genericAlgorithm = EAGeneticAlgorithm(parameters: parameters)
    let result = genericAlgorithm.run()
    print(result.bestPopulation.bestIndividual!.fitness)
    print(result.bestPopulation.bestIndividual!.text)
    
    let python = EAPythonResult(result: result, name: "SkoumalLogo")
    do {
        try python.save(useGlobalBest: false)
    } catch {
        print(error)
    }
}


func evolutionaryAlgorithmAL() {
    let fitnessFunction = EAAckleyFunction()
    let configuration = try! EAEvolutionaryStrategyConfiguration(µ: 20, ρ: 3, selectionStrategy: .plus, λ: 20)
    let parameters = try! EAEvolutionaryStrategyParameters(
        generationsCount: 2000,
        configuration: configuration,
        fitnessFunction: fitnessFunction,
        selection: EARandomSelection(),
        recombination: EAESIntermadiateRecombination(),
        mutation: EAESNormalMutation(threshold: 1.0, σ: 0.1),
        output: .defaultOutput,
        delegate: EAAlgorithmDelegate()
    )
    parameters.delegate?.didFinishGeneration = { algorithm, iterationIndex, population in
        print(population.bestIndividual!.fitness)
    }
    let evolutionaryStrategy = EAEvolutionaryStrategy(parameters: parameters)
    let result = evolutionaryStrategy.run()
    print(result.bestPopulation.bestIndividual!.fitness)
    print(result.bestPopulation.bestIndividual!.data)
}


func particleSwarmAL() {
    let parameters = try! EAParticleSwarmParameters(
        particlesCount: 10,
        iterationsCount: 101,
        velocity: EAParticleSwarmVelocity(maximum: EAAckleyFunction().distance / 30.0),
        learning: EAParticleSwarmLearning.defaultLearning,
        inertiaWeight: EAParticleSwarmInertiaWeight.defaultInertiaWeight,
        fitnessFunction: EAAckleyFunction(),
        output: EAAlgorithmParametersOutput(saveProgress: true),
        delegate: EAAlgorithmDelegate()
    )
    parameters.delegate?.didFinishGeneration = { algorithm, iterationIndex, population in
        print(population.bestIndividual!.fitness)
    }
    let particleSwarm = EAParticleSwarm(parameters: parameters)
    let result = particleSwarm.run()
    print(result.bestPopulation.bestIndividual!.fitness)
    print(result.bestPopulation.bestIndividual!.data)
}


func differentialEvolutionAL() {
    let parameters = try! EADifferentialEvolutionParameters(
        populationCount: 10,
        generationsCount: 101,
        selection: EARandomSelection(),
        mutationStrategy: EADERand1BinMutationStrategy(f: 0.5, λ: 0.5),
        crossover: EADifferentialEvolutionCrossover(cr: 0.9),
        fitnessFunction: EAAckleyFunction(),
        output: EAAlgorithmParametersOutput(saveProgress: true),
        delegate: EAAlgorithmDelegate()
    )
    
    parameters.delegate?.didFinishGeneration = { algorithm, iterationIndex, population in
        print(population.bestIndividual!.fitness)
    }
    let differentialEvolution = EADifferentialEvolution(parameters: parameters)
    let result = differentialEvolution.run()
    print(result.bestPopulation.bestIndividual!.fitness)
    print(result.bestPopulation.bestIndividual!.data)
}



geneticAlgorithmText()
