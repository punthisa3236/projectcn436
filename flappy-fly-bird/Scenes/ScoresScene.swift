//
//  ScoresScene.swift
//  ios-spritekit-flappy-flying-bird
//
//  Created by Tham Thearawiboon on 22/11/2564 BE.
//

import SpriteKit

class ScoresScene: RoutingUtilityScene {
    

    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        fetchScores()
        advanceRainParticleEmitter(for: 10)
    }
    

    
    private func advanceRainParticleEmitter(for amount: TimeInterval) {
        let particleEmitter = childNode(withName: "Rain Particle Emitter") as? SKEmitterNode
        particleEmitter?.advanceSimulationTime(amount)
    }
    
    private func fetchScores() {

        
        if let bestScoreLabel = self.scene?.childNode(withName: "Best Score Label") as? SKLabelNode {
            let bestScore = UserDefaults.standard.integer(for: .bestScore)
            bestScoreLabel.text = "Best: \(bestScore)"
        }
        
        if let lastScoreLabel = self.scene?.childNode(withName: "Last Score Label") as? SKLabelNode {
            let lastScore = UserDefaults.standard.integer(for: .lastScore)
            lastScoreLabel.text = "Last: \(lastScore)"
        }
    }
}
