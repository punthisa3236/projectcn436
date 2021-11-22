//
//  PhysicsCategories.swift
//  ios-spritekit-flappy-flying-bird
//
//  Created by Tham Thearawiboon on 22/11/2564 BE.
//

import Foundation


struct PhysicsCategories : OptionSet {
    let rawValue : UInt32
    
    static let boundary     = PhysicsCategories(rawValue: 1 << 0)
    static let player       = PhysicsCategories(rawValue: 1 << 1)
    static let pipe         = PhysicsCategories(rawValue: 1 << 2)
    static let gap          = PhysicsCategories(rawValue: 1 << 3)
}
