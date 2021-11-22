//
//  Playable.swift
//  ios-spritekit-flappy-flying-bird
//
//  Created by Tham Thearawiboon on 22/11/2564 BE.
//

import Foundation
import CoreGraphics

protocol Playable: class {
    var isAffectedByGravity: Bool { get set }
    var size: CGSize { get set }
}
