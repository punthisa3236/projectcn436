//
//  Updatable.swift
//  ios-spritekit-flappy-flying-bird
//
//  Created by Tham Thearawiboon on 22/11/2564 BE.
//

import Foundation

protocol Updatable: class {
    

    
    var delta: TimeInterval { get }
    var lastUpdateTime: TimeInterval { get }
    var shouldUpdate: Bool { get set }

    
    func update(_ currentTime: TimeInterval)
}


extension Updatable {
    
    
    func computeUpdatable(currentTime: TimeInterval) -> (delta: TimeInterval, lastUpdateTime: TimeInterval) {
        let delta = (self.lastUpdateTime == 0.0) ? 0.0 : currentTime - self.lastUpdateTime
        let lastUpdateTime = currentTime
        
        return (delta: delta, lastUpdateTime: lastUpdateTime)
    }
}
