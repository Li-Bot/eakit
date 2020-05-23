//
//  EAParticleSwarmPopulation.swift
//  EAKit
//
//  Created by Libor Polehna on 17/05/2020.
//  Copyright © 2020 Libor Polehna. All rights reserved.
//

import Foundation


public final class EAParticleSwarmPopulation: EAPopulation<EAParticleSwarmIndividual> {
    
    public override class func getRandomIndividual<FitnessFunction>(type: EADistributionType<Double>, fitnessFunction: FitnessFunction, context: EAContextProtocol?) -> EAParticleSwarmIndividual where IndividualType == FitnessFunction.IndividualType, FitnessFunction : EAFitnessFunctionProtocol {
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
