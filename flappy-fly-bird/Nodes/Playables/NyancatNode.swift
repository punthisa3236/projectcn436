//
//  NyancatNode.swift
//  ios-spritekit-flappy-flying-bird
//
//  Created by Tham Thearawiboon on 22/11/2564 BE.
//

import SpriteKit
import Foundation

class NyancatNode: SKNode, Updatable, Playable, PhysicsContactable {
    


    var size: CGSize
    

    
    var delta: TimeInterval = 0
    var lastUpdateTime: TimeInterval = 0
    var shouldUpdate: Bool = true
    
    var isAffectedByGravity: Bool = true {
        didSet {
            physicsBody?.affectedByGravity = isAffectedByGravity
        }
    }
    
    var shouldAcceptTouches: Bool = true {
        didSet {
            self.isUserInteractionEnabled = shouldAcceptTouches
        }
    }

    var shouldEnablePhysics: Bool = true {
        didSet {
          
            physicsBody?.collisionBitMask = shouldEnablePhysics ? collisionBitMask : 0
        }
    }
    
    var collisionBitMask: UInt32 = PhysicsCategories.pipe.rawValue | PhysicsCategories.boundary.rawValue


    
    private let impact = UIImpactFeedbackGenerator(style: .medium)
    private var animatedGifNode: SKSpriteNode
    

    
    init(animatedGif name: String, correctAspectRatioFor width: CGFloat) {
        animatedGifNode = SKSpriteNode(withAnimatedGif: name, correctAspectRatioFor: width)
        size = animatedGifNode.size
        
        super.init()
        
        preparePlayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        size = .zero
        animatedGifNode = SKSpriteNode(texture: nil, color: .clear, size: .zero)
        
        super.init(coder: aDecoder)
        
        guard let assetName = userData!["assetName"] as? String else {
            fatalError(#function + " asset name was not specified")
        }
        animatedGifNode = SKSpriteNode(withAnimatedGif: assetName, correctAspectRatioFor: 100)
        size = animatedGifNode.size
        
        preparePlayer()
    }
    

    
    private func preparePlayer() {
        animatedGifNode.name = self.name
        animatedGifNode.position = .zero
        animatedGifNode.zPosition = 50
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width - 32, height: size.height - 32))
        physicsBody?.categoryBitMask = PhysicsCategories.player.rawValue
        physicsBody?.contactTestBitMask = PhysicsCategories.pipe.rawValue | PhysicsCategories.gap.rawValue | PhysicsCategories.boundary.rawValue
        physicsBody?.collisionBitMask = collisionBitMask
        
        physicsBody?.mass /= 7
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0.0
        
        self.addChild(animatedGifNode)
    }
    
  
    
    func update(_ timeInterval: CFTimeInterval) {
        delta = lastUpdateTime == 0.0 ? 0.0 : timeInterval - lastUpdateTime
        lastUpdateTime = timeInterval
        
        guard let physicsBody = physicsBody else {
            return
        }
        
        let velocityX = physicsBody.velocity.dx
        let velocityY = physicsBody.velocity.dy
        let threshold: CGFloat = 350
        
        if velocityY > threshold {
            physicsBody.velocity = CGVector(dx: velocityX, dy: threshold)
        }
        
        let velocityValue = velocityY * (velocityY < 0 ? 0.004 : 0.002)
        zRotation = velocityValue.clamp(min: -1, max: 1)
    }
    
}


extension NyancatNode: Touchable {
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !shouldAcceptTouches { return }
        
        impact.impactOccurred()
        
        isAffectedByGravity = true
    
        physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
    }
}
