//
//  PhysicsContactable.swift
//  flappy-fly-bird
//
//  Created by Tham Thearawiboon on 22/11/2564 BE.
//

import SpriteKit


protocol PhysicsContactable {
    var shouldEnablePhysics: Bool { get set }
    var collisionBitMask: UInt32 { get }
}
