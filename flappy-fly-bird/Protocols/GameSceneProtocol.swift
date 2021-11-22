//
//  GameSceneProtocol.swift
//  ios-spritekit-flappy-flying-bird
//
//  Created by Tham Thearawiboon on 22/11/2564 BE.
//

import Foundation
import SpriteKit

protocol GameSceneProtocol {
    

    var scene: SKScene? { get }
    
    var updatables: [Updatable] { get }
    var touchables: [Touchable] { get }
    
    
    init?(with scene: SKScene)
    
}
