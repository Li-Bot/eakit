## Components

Each evolutionary algorithm is decomposed to components. The components are interchangeable between algorithms. Each component is defined by protocol.

### ```EAFitnessFunctionProtocol```
Fitness Function protocol is the most important component. It defines a description of your problem. 

There are already built-in some fitness functions:
- Artificial Landscapes
  - ```EASphereFunction```
  - ```EARosenbrockFunction```
  - ```EARastriginFunction```
  - ```EAAckleyFunction```
  - ```EASchwefelFunction```
  - ```EAEasomFunction```
- TSP
  - ```EATSPFunction```
- Others
  - ```EATextFunction```

### ```EASelectionProtocol```
Selection component is used for selecting parents from a pupulation.

There are already built-in some selections:
- General
  - ```EARandomSelection```
  - ```EARouletteSelection```
  - ```EATournamentSelection```

### ```EACrossoverProtocol```
Crossover component is used for crossing individuals, e.g. two parents selected from a selection component to create offsprings. 

There are already built-in some crossovers:
- General
  - ```EASinglePointCrossover```
  - ```EATwoPointCrossover```
  - ```EAKPointCrossover```
  - ```EAUniformCrossover```
- TSP (Special crossovers for TSP)
  - ```EATSPSinglePointCrossover```
  - ```EATSPTwoPointCrossover```
- Differential Evolution (Special crossovers for DE)
  - ```EADifferentialEvolutionCrossover```
  
### ```EAMutationProtocol```
Mutation component is used for mutating individuals, e.g. mutate offsprings from a crossover component. 

There are already built-in some mutations:
- General
  - ```EASwapMutation```
  - ```EAFloatingNumericMutation```
  - ```EAReplacementMutation```
  - ```EANormalDistributionMutation```
- Evolutionary Strategy (Special mutations for ES)
  - ```EAESNormalMutation```

### ```EAEvolutionaryStrategyRecombinationProtocol```
This component is made specially for Evolutionary Strategy algorithm. However, you can use it in your custom algorithm if necessary.
Recombination component is used for combination multiple individuals to generate one offspring, e.g. recombine parents selected from a selection component to create one recombinant (offspring).

There are already built-in some recombinations:
- ```EAESIntermadiateRecombination```
- ```EAESDiscreteRecombination```

### ```EADifferentialEvolutionMutationStrategyProtocol```
This component is made specially for Differential Evolution algorithm. However, you can use it in your custom algorithm if necessary.
Mutation Strategy component is used for mutating individuals based on active individual, global best individual and others random selected individuals.

There are already built-in some mutation strategies:
- ```EADERand1BinMutationStrategy```

### ```EAIndividualProtocol```
One of the core components. Individual represents a solution of your problem. It is almost used throughout the all components. 

There are already built-in some individuals:
- General
  - ```EAIndividual<DataType>```, which is generic and you can define data type of your individual
  - ```EADoubleIndividual```, data type is Double
  - ```EAIntegerIndividual```, data type is Int
  - ```EACharacterIndividual```, data type is Character
- Particle Swarm (Special individuals for PS)
  - ```EAParticleSwarmIndividual```

### ```EAPopulationProtocol```
One of the core components. Population consists of array of individuals. It is almost used throughout the all components. 

There are already built-in some populations:
- General
  - ```EAPopulation<IndividualType: EAIndividualProtocol>```, which is generic and you can define individual type of your population
- Particle Swarm (Special individuals for PS)
  - ```EAParticleSwarmPopulation```
  
### ```EADistributionProtocol```
Distribution component is used for generating random numbers.

There are already built-in some distributions:
- ```EAUniformDistribution```
- ```EANormalDistribution```

### ```EAAlgorithmProtocol```
Algorithm component is used for implementing your own evolutionary algorithm. It also includes three others components: ```EAAlgorithmDelegateProtocol```, ```EAAlgorithmParametersProtocol``` and ```EAAlgorithmResultProtocol```.

- ```EAAlgorithmDelegateProtocol``` is used for tracking progress while a algorithm is running (you can use it for updating UI)
  - ```EAAlgorithmDelegate``` - basic built-in implementation ready to use. There is no need to implement it by yourself.
- ```EAAlgorithmParametersProtocol``` is used for defining parameters of an evolutionary algorithm. Just to keep parameters and logic of an algorithm apart.
  - ```EAAlgorithmParameters``` - basic built-in implementation ready to use. There is no need to implement it by yourself.
- ```EAAlgorithmResultProtocol``` is used for getting result of an algorithm. 
  - ```EAAlgorithmParametersOutput``` - basic built-in implementation ready to use. There is no need to implement it by yourself.

I recommend you to use all those components mentioned above when you want to create your own evolutionary algorithm. It will be easier and consistent.
