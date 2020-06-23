<p align="center">
  <img src="Docs/Images/eakit_logo.gif">
</p>

# EAKit
EAKit is a Framework of Evolutionary Algorithms written in Swift. 
It is fully generic, architecture (algorithms) based on (interchangeable) components, simple to use and you can build your own evolutionary algorithm by using existing components.

## Contents
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Components](#components)
- [Custom Implementation](#custom-implementation)
- [Future](#future)
- [License](#license)

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

### Cocoapods


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

Find out more about [components here](Docs/components.md).

## Custom Implementation
Let's look at how simple it is to implement your own components & evolutionary algorithms. 

### Fitness Function
If you want to have your problem solved by some of already implemented algorithms described above, you have to implement your own fitness function. Do not worry, it is a piece of cake!

```swift
struct MyFunction: EAFitnessFunctionProtocol {
    
    typealias IndividualType = EADoubleIndividual
    
    let dimension: Int
    let range: ClosedRange<Double>
    
    private let domainValidation: EASingleRangeDomainValidation<IndividualType>
    
    init() {
        self.dimension = 2
        self.range = -5.0 ... 5.0
        domainValidation = EASingleRangeDomainValidation(domain: EARangeDomain(range: range))
    }
    
    func evaluate(individual: IndividualType) -> Double {
        var fitness: Double = 0.0
        for x in individual.data {
            fitness += x * x
        }
        return fitness
    }
    
    func getRandomIndividual(type: EADistributionType<IndividualType.DataType>) -> IndividualType {
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
    
    func validateDomains(individual: IndividualType) -> IndividualType {
        return domainValidation.validate(individual: individual, fitnessFunction: self) ?? individual
    }
    
}
```

1. ```EAFitnessFunctionProtocol``` has ```IndividualType``` (which conforms to ```EAIndividualProtocol```) as a associated type (a generic parameter of protocol). You can define the associated type as ```typealias IndividualType = EADoubleIndividual```.
2. ```func evaluate(individual: EADoubleIndividual) -> Double```.
  - You should implement your problem in this method to calculate a fitness value of given individual.
3. ```func getRandomIndividual(type: EADistributionType<EADoubleIndividual.DataType>) -> EADoubleIndividual```
  - Generate a random individual in your search space (problem space).
4. ```func validateDomains(individual: EADoubleIndividual) -> EADoubleIndividual```.
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
    
    typealias DataType = Float
    
    var position: [DataType] {
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
    
    var data: [DataType]
    var velocity: [DataType]
    private(set) var bestPosition: [DataType]
    
    public required init() {
        bestPosition = []
        velocity = []
        data = []
        fitness = Double.greatestFiniteMagnitude
    }
    
}
```

1. ```EAIndividualProtocol``` has ```DataType``` as a associated type (a generic parameter of protocol). You can define the associated type as ```typealias DataType = Float```. 
2. You have to implement ```fitness: Double``` and ```data: [DataType]``` properties as required by protocol.
3. That's it! You can use your own individual in your fitness function or in other components.

### Selection
Selection of individuals (parents) from given population.

```swift
struct MySelection: EASelectionProtocol {
    
    typealias PopulationType = EAPopulation<EADoubleIndividual>
    
    let isElitism: Bool
    
    init(isElitism: Bool = false) {
        self.isElitism = isElitism
    }
    
    func createNewPopulation(population: PopulationType) -> PopulationType? {
        if let individual = population.bestIndividual, isElitism {
            return PopulationType(individuals: [individual])
        }
        return nil
    }
    
    func prepare(population: PopulationType, context: EAContextProtocol?) {
    }
    
    func selectParents(population: PopulationType, count: Int, context: EAContextProtocol?) -> [PopulationType.IndividualType] {
        let distribution = EAUniformDistribution(range: 0 ... population.individuals.count - 1)
        let indexes = distribution.random(count: UInt(count))
        return indexes.map { index -> PopulationType.IndividualType in
            return population.individuals[index]
        }
    }
    
}
```

1. ```EASelectionProtocol``` has ```PopulationType``` as a associated type (a generic parameter of protocol). You can define the associated type as ```typealias PopulationType = EAPopulation<EADoubleIndividual>```. 
2. ```func createNewPopulation(population: PopulationType) -> PopulationType?```.
  - Create a new population from given population, e.g. appling elitism.
3. ```func prepare(population: PopulationType, context: EAContextProtocol?)```.
  - Use this method for preprocessing current population.
4. ```func selectParents(population: PopulationType, count: Int, context: EAContextProtocol?) -> [PopulationType.IndividualType]```.
  - Selection logic should be implemented here.
5. That's it! You can use your own selection in some of already implemented algorithms.

### Crossover
Crossover two individuals (parents) to create offsprings.

```swift
struct MyCrossover: EACrossoverProtocol {
    
    typealias IndividualType = EADoubleIndividual
    
    let threshold: Double
    
    init(threshold: Double) {
        self.threshold = threshold
    }
        
    func cross(first: IndividualType, second: IndividualType) -> [IndividualType] {
        let size = first.data.count
        let uniformDistribution = EAUniformDistribution(range: 0.0 ... 1.0)
        var firstIndividual = IndividualType()
        var secondIndividual = IndividualType()
        
        for dataIndex in 0 ..< size {
            if uniformDistribution.random() <= 0.5 {
                firstIndividual.data.append(first.data[dataIndex])
                secondIndividual.data.append(second.data[dataIndex])
            } else {
                firstIndividual.data.append(second.data[dataIndex])
                secondIndividual.data.append(first.data[dataIndex])
            }
        }
        
        return [firstIndividual, secondIndividual]
    }
}
```

1. ```EACrossoverProtocol``` has ```IndividualType``` as a associated type (a generic parameter of protocol). You can define the associated type as ```typealias IndividualType = EADoubleIndividual```.
2. You have to implement ```threshold: Double``` property as required by protocol.
3. ```func cross(first: IndividualType, second: IndividualType) -> [IndividualType]```.
  - Crossover logic should be implemented here.
4. That's it! You can use your own crossover in some of already implemented algorithms.

### Mutation
Mutate given individual.

```swift
struct MyMutation: EAMutationProtocol {
    
    typealias IndividualType = EADoubleIndividual
    
    let threshold: Double
    let count: UInt
    
    init(threshold: Double, count: UInt) {
        self.threshold = threshold
        self.count = count
    }
    
    mutating func prepare(context: EAContextProtocol?) {
    }
    
    func mutate(individual: IndividualType, context: EAContextProtocol?) -> IndividualType {
        var individual = individual
        let distribution = EAUniformDistribution(range: 0 ... individual.data.count - 1)
        
        for _ in 0 ..< count {
            let indexes = distribution.random(count: 2)
            
            let temp = individual.data[indexes[0]]
            individual.data[indexes[0]] = individual.data[indexes[1]]
            individual.data[indexes[1]] = temp
        }
        
        return individual
    }
    
}
```

1. ```EAMutationProtocol``` has ```IndividualType``` as a associated type (a generic parameter of protocol). You can define the associated type as ```typealias IndividualType = EADoubleIndividual```.
2. You have to implement ```threshold: Double``` and ```count: UInt``` properties as required by protocol.
3. ```func prepare(context: EAContextProtocol?)```.
  - Use this method for preprocessing data if necessary.
4. ```func mutate(individual: IndividualType, context: EAContextProtocol?) -> IndividualType```.
  - Mutation logic should be implemented here.
5. That's it! You can use your own mutation in some of already implemented algorithms.

### Recombination
Create a recombinant from given individuals.

```swift
struct MyRecombination: EAEvolutionaryStrategyRecombinationProtocol {
    
    typealias IndividualType = EADoubleIndividual
    
    public init() {
    }
    
    func recombine(individuals: [IndividualType]) -> IndividualType {
        let uniformDistribution = EAUniformDistribution(range: 0 ... individuals.count - 1)
        var recombinant = IndividualType()
        for dataIndex in 0 ..< (individuals.first?.data.count ?? 0) {
            let randomIndex = uniformDistribution.random()
            let data = individuals[randomIndex].data[dataIndex]
            recombinant.data.append(data)
        }
        return recombinant
    }
    
}
```

1. ```EAEvolutionaryStrategyRecombinationProtocol``` has ```IndividualType``` as a associated type (a generic parameter of protocol). You can define the associated type as ```typealias IndividualType = EADoubleIndividual```.
2. ```func recombine(individuals: [IndividualType]) -> IndividualType```.
  - Recombination logic should be implemented here.
3. That's it! You can use your own recombination in some of already implemented algorithms.

### Mutation Strategy
Mutate individuals to create a mutated individual from given active individual, global best individual and others individuals.

```swift
struct MyMutationStrategy: EADifferentialEvolutionMutationStrategyProtocol {
    
    typealias IndividualType = EADoubleIndividual
    
    let f: IndividualType.DataType
    let λ: IndividualType.DataType
    let parentsCount: Int = 3
    
    init(f: IndividualType.DataType, λ: IndividualType.DataType) {
        self.f = f
        self.λ = λ
    }
    
    func mutate(activeIndividual: IndividualType, bestIndividual: IndividualType, individuals: [IndividualType], context: EADifferentialEvolutionContext) -> IndividualType {
        var offspring = IndividualType()
        
        for index in 0 ..< activeIndividual.data.count {
            let value = individuals[2].data[index] + f * (individuals[0].data[index] - individuals[1].data[index])
            offspring.data.append(value)
        }
        
        return offspring
    }
    
}
```

1. ```EADifferentialEvolutionMutationStrategyProtocol``` has ```IndividualType``` as a associated type (a generic parameter of protocol). You can define the associated type as ```typealias IndividualType = EADoubleIndividual```.
2. You have to implement ```parentsCount: Int``` property as required by protocol.
3. ```func mutate(activeIndividual: IndividualType, bestIndividual: IndividualType, individuals: [IndividualType], context: EADifferentialEvolutionContext) -> IndividualType```.
  - Mutation strategy logic should be implemented here.
4. That's it! You can use your own mutation strategy in some of already implemented algorithms.

### Population
Population consists of array of individuals and keep the best individual in the population. 

1. You can implement the ```EAPopulationProtocol``` protocol to create your population.

2. You can create a subclass of ```EAPopulation<IndividualType>``` and override methods or added new ones.
```swift
final class MyPopulation: EAPopulation<EAParticleSwarmIndividual> {
    
    override class func getRandomIndividual<FitnessFunction>(type: EADistributionType<Double>, fitnessFunction: FitnessFunction, context: EAContextProtocol?) -> EAParticleSwarmIndividual where IndividualType == FitnessFunction.IndividualType, FitnessFunction : EAFitnessFunctionProtocol {
        let individual = super.getRandomIndividual(type: type, fitnessFunction: fitnessFunction, context: context)
        guard let ctx = context as? EAParticleSwarmContext else {
            return individual
        }
        
        let velocityMin = ctx.velocity.maximum * -1.0
        let velocityMax = ctx.velocity.maximum
        let uniformDistribution = EAUniformDistribution(range: velocityMin ... velocityMax)
        
        for _ in 0 ..< fitnessFunction.dimension {
            individual.velocity.append(uniformDistribution.random())
        }
        
        return individual
    }
    
}
```

1. ```EAPopulation``` or ```EAPopulationProtocol``` has ```IndividualType``` as a associated type (a generic parameter of protocol). You can define the associated type as a generic parameter of ```EAPopulation``` or  ```typealias IndividualType = EAParticleSwarmIndividual```.
2. You have to implement ```bestIndividual: IndividualType?``` and ```individuals: [IndividualType]``` properties as required by protocol.
3. ```static func getRandomIndividual<FitnessFunction: EAFitnessFunctionProtocol>(type: EADistributionType<IndividualType.DataType>, fitnessFunction: FitnessFunction, context: EAContextProtocol?) -> IndividualType where FitnessFunction.IndividualType == IndividualType```.
  - Logic of creating random individual should be implemented here.
4. ```static func getRandomPopulation<FitnessFunction: EAFitnessFunctionProtocol>(type: EADistributionType<IndividualType.DataType>, fitnessFunction: FitnessFunction, size: UInt, context: EAContextProtocol?) -> Self where FitnessFunction.IndividualType == IndividualType```.
  - Logic of creating random population should be implemented here.
5. That's it! You can use your own population in your own evolutionary algorithm.

### Algorithm
This is the component where you will use all components implemented above to create your own evolutionary algorithm.

1. Parameters of an algorithm.
```swift
final class MyParameters<FitnessFunctionType: EAFitnessFunctionProtocol, SelectionType: EASelectionProtocol, MutationStrategyType: EADifferentialEvolutionMutationStrategyProtocol, CrossoverType: EACrossoverProtocol>: EAAlgorithmParameters<EADifferentialEvolution<FitnessFunctionType, SelectionType, MutationStrategyType, CrossoverType>, EAPopulation<FitnessFunctionType.IndividualType>> where FitnessFunctionType.IndividualType == CrossoverType.IndividualType, EAPopulation<FitnessFunctionType.IndividualType> == SelectionType.PopulationType, FitnessFunctionType.IndividualType == MutationStrategyType.IndividualType {
    
    public var np: UInt {
        populationCount
    }
    var selection: SelectionType
    let mutationStrategy: MutationStrategyType
    let crossover: CrossoverType
    
    init(populationCount: UInt, generationsCount: UInt, selection: SelectionType, mutationStrategy: MutationStrategyType, crossover: CrossoverType, fitnessFunction: FitnessFunctionType, output: EAAlgorithmParametersOutput = .defaultOutput, delegate: EAAlgorithmDelegate<EADifferentialEvolution<FitnessFunctionType, SelectionType, MutationStrategyType, CrossoverType>, EAPopulation<FitnessFunctionType.IndividualType>>? = nil) throws {
        self.selection = selection
        self.mutationStrategy = mutationStrategy
        self.crossover = crossover
        try super.init(populationCount: populationCount, generationsCount: generationsCount, fitnessFunction: fitnessFunction, output: output, delegate: delegate)
    }
    
}
```

1.1 Use ```EAAlgorithmParameters``` to create a subclass and add others parameters.
1.2 ```EAAlgorithmParameters``` has ```AlgorithmType``` and ```PopulationType``` as a generic parameter. Define these generic parameters in the signature of your subclass, e.g. ```EAAlgorithmParameters<EADifferentialEvolution<FitnessFunctionType, SelectionType, MutationStrategyType, CrossoverType>, EAPopulation<FitnessFunctionType.IndividualType>>```.
1.3 Define generic constraints to assure that all generic parameters have the same ```PopulationType``` and ```IndividualType```.
1.4 Create a constructor and call super constuctor.

2. An Algorithm
```swift
final class MyAlgorithm<FitnessFunctionType: EAFitnessFunctionProtocol, SelectionType: EASelectionProtocol, MutationStrategyType: EADifferentialEvolutionMutationStrategyProtocol, CrossoverType: EACrossoverProtocol>: EAAlgorithmProtocol where EAPopulation<FitnessFunctionType.IndividualType> == SelectionType.PopulationType, FitnessFunctionType.IndividualType == MutationStrategyType.IndividualType, FitnessFunctionType.IndividualType == CrossoverType.IndividualType {
    
    let parameters: EADifferentialEvolutionParameters<FitnessFunctionType, SelectionType, MutationStrategyType, CrossoverType>
    private let uniformUnifiedDistribution = EAUniformDistribution(range: 0.0 ... 1.0)
    
    init(parameters: EADifferentialEvolutionParameters<FitnessFunctionType, SelectionType, MutationStrategyType, CrossoverType>) {
        self.parameters = parameters
    }
    
    func run() -> EAAlgorithmResult<EAPopulation<FitnessFunctionType.IndividualType>> {
        let context = EADifferentialEvolutionContext()
        var currentPopulation = PopulationType.getRandomPopulation(type: .uniform, fitnessFunction: parameters.fitnessFunction, size: parameters.populationCount, context: context)
        let result = EAAlgorithmResult(population: currentPopulation)
        
        for generationIndex in 0 ..< parameters.generationsCount - 1 {
            let population = PopulationType(individuals: [])
            
            parameters.selection.prepare(population: currentPopulation, context: context)
            for individual in currentPopulation.individuals {
                let parents = parameters.selection.selectParents(population: currentPopulation, count: parameters.mutationStrategy.parentsCount, context: context)
                var offspring = parameters.mutationStrategy.mutate(activeIndividual: individual, bestIndividual: currentPopulation.bestIndividual!, individuals: parents, context: context)
                offspring = parameters.crossover.cross(first: individual, second: offspring).first!
                offspring = parameters.fitnessFunction.validateDomains(individual: offspring)
                offspring.fitness = parameters.fitnessFunction.evaluate(individual: offspring)
                
                if offspring.fitness < individual.fitness {
                    population.append(individual: offspring)
                } else {
                    population.append(individual: individual)
                }
            }
            
            currentPopulation = population
            result.append(population: population, keepBestOnly: !parameters.output.saveProgress)
            parameters.delegate?.didFinishGeneration?(self, generationIndex, currentPopulation)
        }
        
        return result
    }
    
}
```

2.1 Define all generic parameters as you did in 1. step (If you want to avoid this, you do not have to separate parameters of algorithm and algorithm itself. I do, because it keeps logic of algorithm clean).
2.2 ```func run() -> EAAlgorithmResult<EAPopulation<FitnessFunctionType.IndividualType>>``` 
  - Implementation logic of an algorithm should be implemented here.
2.3 That's it! You have your own generic evolutionary algorithm and you can use it.

## Future
- More evolutionary algorithms
- More components 
- More built-in functions

## License
EAKit is released under the GNU GPLv3 license. See the [LICENSE here](LICENSE.md).


