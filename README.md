<p align="center">
  <img src="Docs/Images/eakit_logo.gif">
</p>

# EAKit
EAKit is a Framework of Evolutionary Algorithms written in Swift. 
It is fully generic, simple to use and you can build your own evolutionary algorithm by using existing components. 

## Features
- [x] Genetic Algorithm
- [x] Evolutionary Strategy
- [x] Particle Swarm
- [x] Differential Evolution
- [x] Hill Climbing

## Requirements
- iOS 8+ / macOS 10.9+
- Xcode 10+
- Swift 5+

## Installation

### Carthage

### Swift Package Manager

### Swift Scripting

## Usage
Let's look at how simple it is!

### Hill Climbing

```swift
// Parameters of Hill Climbing
let parameters = try! EAHillClimbingParameters(
    populationCount: 20,
    generationsCount: 101,
    fitnessFunction: EAAckleyFunction(),
    deviation: 0.5
)
// Run the algorithm
let algorithm = EAHillClimbing(parameters: parameters)
let result = algorithm.run()
// Show result
print(result.bestPopulation.bestIndividual?.fitness)
print(result.bestPopulation.bestIndividual?.data)
```

<p align="center">
  <img src="Docs/Images/hill_climbing.gif">
</p>

### Genetic Algorithm

```swift
// Data of TSP Fitness Function
let cities = [
    EATSPCity("A", [60.0, 200.0]), EATSPCity("B", [80.0, 200.0]), EATSPCity("C", [80.0, 180.0]),
    EATSPCity("D", [140.0, 180.0]), EATSPCity("E", [20.0, 160.0]), EATSPCity("F", [100.0, 160.0]),
    EATSPCity("G", [200.0, 160.0]), EATSPCity("H", [140.0, 140.0]), EATSPCity("I", [40.0, 120.0]),
    EATSPCity("J", [100.0, 120.0]), EATSPCity("K", [180.0, 100.0]), EATSPCity("L", [60.0, 80.0]),
    EATSPCity("M", [120.0, 80.0]), EATSPCity("N", [180.0, 60.0]), EATSPCity("O", [20.0, 40.0]),
    EATSPCity("P", [100.0, 40.0]), EATSPCity("Q", [200.0, 40.0]), EATSPCity("R", [20.0, 20.0]),
    EATSPCity("S", [60.0, 20.0]), EATSPCity("T", [160.0, 20.0])
]
let fitnessFunction = EATSPFunction(cities: cities)
// Parameters of Genetic Algorithm
let parameters = try! EAGeneticAlgorithmParameters(
    populationCount: 20,
    generationsCount: 301,
    fitnessFunction: fitnessFunction,
    isElitism: true,
    selection: EARandomSelection(isElitism: true),
    crossover: EATSPTwoPointCrossover(threshold: 1.0),
    mutation: EASwapMutation(threshold: 0.9, count: 1)
)
// Run the algorithm
let algorithm = EAGeneticAlgorithm(parameters: parameters)
let result = algorithm.run()
// Show result
print(result.bestPopulation.bestIndividual?.fitness)
print(result.bestPopulation.bestIndividual?.data)
```

<p align="center">
  <img src="Docs/Images/genetic_algorithm.gif">
</p>

### Evolutionary Strategy
```swift
// Configuration of Evolutionary Strategy 
let configuration = try! EAEvolutionaryStrategyConfiguration(µ: 20, ρ: 3, selectionStrategy: .plus, λ: 20)
// Parameters of Evolutionary Strategy
let parameters = try! EAEvolutionaryStrategyParameters(
    generationsCount: 101,
    configuration: configuration,
    fitnessFunction: EAAckleyFunction(),
    selection: EARandomSelection(),
    recombination: EAESIntermadiateRecombination(),
    mutation: EAESNormalMutation(threshold: 1.0, σ: 0.5)
)
// Run the algorithm
let algorithm = EAEvolutionaryStrategy(parameters: parameters)
let result = algorithm.run()
// Show result
print(result.bestPopulation.bestIndividual?.fitness)
print(result.bestPopulation.bestIndividual?.data)
```

<p align="center">
  <img src="Docs/Images/evolutionary_strategy.gif">
</p>

### Particle Swarm

```swift
// Parameters of Particle Swarm
let parameters = try! EAParticleSwarmParameters(
    particlesCount: 10,
    iterationsCount: 101,
    velocity: EAParticleSwarmVelocity(maximum: EASphereFunction().distance / 30.0),
    learning: .defaultLearning,
    inertiaWeight: .defaultInertiaWeight,
    fitnessFunction: EAAckleyFunction()
)
// Run the algorithm
let algorithm = EAParticleSwarm(parameters: parameters)
let result = algorithm.run()
// Show result
print(result.bestPopulation.bestIndividual?.fitness)
print(result.bestPopulation.bestIndividual?.data)
```

<p align="center">
  <img src="Docs/Images/particle_swarm.gif">
</p>

### Differential Evolution

```swift
// Parameters of Differential Evolution
let parameters = try! EADifferentialEvolutionParameters(
    populationCount: 10,
    generationsCount: 101,
    selection: EARandomSelection(),
    mutationStrategy: EADERand1BinMutationStrategy(f: 0.5, λ: 0.5),
    crossover: EADifferentialEvolutionCrossover(cr: 0.9),
    fitnessFunction: EAAckleyFunction()
)
// Run the algorithm
let algorithm = EADifferentialEvolution(parameters: parameters)
let result = algorithm.run()
// Show result
print(result.bestPopulation.bestIndividual?.fitness)
print(result.bestPopulation.bestIndividual?.data)
```

<p align="center">
  <img src="Docs/Images/differential_evolution.gif">
</p>

## Components
Each evolutionary algorithm is decomposed to components. The components are interchangeable between algorithms. Each component is defined by protocol.

### EAFitnessFunctionProtocol
Fitness Function protocol is the most important component. It defines a description of your problem. 

There are already built-in some fitness functions:
- Artificial Landscapes
  - EASphereFunction
  - EARosenbrockFunction
  - EARastriginFunction
  - EAAckleyFunction
  - EASchwefelFunction
  - EAEasomFunction
- TSP
  - EATSPFunction
- Others
  - EATextFunction

### EASelectionProtocol
Selection component is used for selecting parents from a pupulation.

There are already built-in some selections:
- General
  - EARandomSelection
  - EARouletteSelection
  - EATournamentSelection

### EACrossoverProtocol
Crossover component is used for crossing individuals, e.g. two parents selected from a selection component to create offsprings. 

There are already built-in some crossovers:
- General
  - EASinglePointCrossover
  - EATwoPointCrossover
  - EAKPointCrossover
  - EAUniformCrossover
- TSP (Special crossovers for TSP)
  - EATSPSinglePointCrossover
  - EATSPTwoPointCrossover
- Differential Evolution (Special crossovers for DE)
  - EADifferentialEvolutionCrossover
  
### EAMutationProtocol
Mutation component is used for mutating individuals, e.g. mutate offsprings from a crossover component. 

There are already built-in some mutations:
- General
  - EASwapMutation
  - EAFloatingNumericMutation
  - EAReplacementMutation
  - EANormalDistributionMutation
- Evolutionary Strategy (Special mutations for ES)
  - EAESNormalMutation

### EAEvolutionaryStrategyRecombinationProtocol
This component is made specially for Evolutionary Strategy algorithm. However, you can use it in your custom algorithm if necessary.
Recombination component is used for combination multiple individuals to generate one offspring, e.g. recombine parents selected from a selection component to create one recombinant (offspring).

There are already built-in some recombinations:
- EAESIntermadiateRecombination
- EAESDiscreteRecombination

### EADifferentialEvolutionMutationStrategyProtocol
This component is made specially for Differential Evolution algorithm. However, you can use it in your custom algorithm if necessary.
Mutation Strategy component is used for mutating individuals based on active individual, global best individual and others random selected individuals.

There are already built-in some mutation strategies:
- EADERand1BinMutationStrategy

### EAIndividualProtocol
One of the core components. Individual represents a solution of your problem. It is almost used throughout the all components. 

There are already built-in some individuals:
- General
  - EAIndividual<DataType>, which is generic and you can define data type of your individual
  - EADoubleIndividual, data type is Double
  - EAIntegerIndividual, data type is Int
  - EACharacterIndividual, data type is Character
- Particle Swarm (Special individuals for PS)
  - EAParticleSwarmIndividual

### EAPopulationProtocol
One of the core components. Population consists of array of individuals. It is almost used throughout the all components. 

There are already built-in some populations:
- General
  - EAPopulation<IndividualType: EAIndividualProtocol>, which is generic and you can define individual type of your population
- Particle Swarm (Special individuals for PS)
  - EAParticleSwarmPopulation

## Custom Implementation
Let's look at how simple it is to implement your own components & evolutionary algorithms. 

### Fitness Function
If you want to have your problem solved by some of already implemented algorithms described above, you have to implement your own fitness function. Do not worry, it is a piece of cake!

```swift
struct MySphereFunction: EAFitnessFunctionProtocol {
    
    let dimension: Int
    let range: ClosedRange<Double>
    
    private let domainValidation: EASingleRangeDomainValidation<EADoubleIndividual>
    
    init() {
        self.dimension = 2
        self.range = -5.0 ... 5.0
        domainValidation = EASingleRangeDomainValidation(domain: EARangeDomain(range: range))
    }
    
    func evaluate(individual: EADoubleIndividual) -> Double {
        var fitness: Double = 0.0
        for x in individual.data {
            fitness += x * x
        }
        return fitness
    }
    
    func getRandomIndividual(type: EADistributionType<EADoubleIndividual.DataType>) -> EADoubleIndividual {
        var individual = IndividualType()
        
        let distribution = EAUniformDistribution(range: range)
        for _ in 0 ..< dimension {
            let randomValue = distribution.random()
            individual.data.append(randomValue)
        }
        individual = validateDomains(individual: individual)
        individual.fitness = evaluate(individual: individual)
        
        return individual
    }
    
    func validateDomains(individual: EADoubleIndividual) -> EADoubleIndividual {
        return domainValidation.validate(individual: individual, fitnessFunction: self) ?? individual
    }
    
}
```

1. ```EAFitnessFunctionProtocol``` has IndividualType (which conforms to ```EAIndividualProtocol```) as a associated type (a generic parameter of protocol). If you define the type of IndividualType in signatures of methods, such as: evaluate and validateDomains, compiler automatically resolve the type of generic parameter (IndividualType).
2. ```func evaluate(individual: EADoubleIndividual) -> Double```
  - You should implement your problem in this method to calculate a fitness value of given individual.
3. ```func getRandomIndividual(type: EADistributionType<EADoubleIndividual.DataType>) -> EADoubleIndividual```
  - Generate a random individual in your search space (problem space).
4. ```func validateDomains(individual: EADoubleIndividual) -> EADoubleIndividual```
  - Use this method to validate domains of given individual, e.g. when your search space is limited or is discrete, you have to define boundaries of search space to prevent individuals from being in forbidden areas.
5. That's it! You can use some of algorithms described above to have your problem solved.

### Individual 
As you can see, we used ```EADoubleIndividual``` in our custom implementation of fitness function ```MySphereFunction``` above. However, you can define your own individual to meet your expectations.

1. If you only need different type of individual, you can use generic ```EAIndividual<DataType>``` class:
```swift
typealias MyIndividual = EAIndividual<String>
```

2. If you need more sophisticated individual, you have to implement custom class/struct:
```swift
class MyIndividual: EAIndividualProtocol {
    
    var position: [Float] {
        set { data = newValue }
        get { return data }
    }
    
    var fitness: Double {
           didSet {
               if fitness < oldValue {
                   bestPosition = position
               }
           }
       }
    
    var data: [Float]
    var velocity: [Float]
    private(set) var bestPosition: [Float]
    
    public required init() {
        bestPosition = []
        velocity = []
        data = []
        fitness = Double.greatestFiniteMagnitude
    }
    
}
```

1. ```EAIndividualProtocol``` has DataType as a associated type (a generic parameter of protocol). If you define the type of data property, compiler automatically resolve the type of generic parameter (DataType). 
2. You have to implement ```fitness: Double``` a ```data: [DataType]``` properties as required by protocol.
3. That's it! You can use your own individual in your fitness function or in other components.
