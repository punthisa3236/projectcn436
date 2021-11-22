//
//  SettingsScene.swift
//  ios-spritekit-flappy-flying-bird
//
//  Created by Tham Thearawiboon on 22/11/2564 BE.
//

import SpriteKit

class SettingsScene: RoutingUtilityScene, ToggleButtonNodeResponderType, TriggleButtonNodeResponderType {

    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        let soundButton = scene?.childNode(withName: "Sound") as? ToggleButtonNode
        soundButton?.isOn = UserDefaults.standard.bool(for: .isSoundOn)
        
        let difficultyButton = scene?.childNode(withName: "Difficulty") as? TriggleButtonNode
        let difficultyLevel = UserDefaults.standard.getDifficultyLevel()
        let difficultyState = TriggleButtonNode.TriggleState.convert(from: difficultyLevel)
        difficultyButton?.triggle = .init(state: difficultyState)
    }
    

    
    func toggleButtonTriggered(toggle: ToggleButtonNode) {
        UserDefaults.standard.set(toggle.isOn, for: .isSoundOn)
    }
    

    
    func triggleButtonTriggered(triggle: TriggleButtonNode) {
        debugPrint("triggleButtonTriggered")
        let diffuculty = triggle.triggle.toDifficultyLevel()
        UserDefaults.standard.set(difficultyLevel: diffuculty)
    }
    
}
