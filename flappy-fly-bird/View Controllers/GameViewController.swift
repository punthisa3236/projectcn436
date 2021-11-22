//
//  GameViewController.swift
//  ios-spritekit-flappy-flying-bird
//
//  Created by Tham Thearawiboon on 22/11/2564 BE.
//

import UIKit
import SpriteKit
import GameplayKit

enum Scenes: String {
    case title = "TitleScene"
    case game = "GameScene"
    case setting = "SettingsScene"
    case score = "ScoreScene"
    case pause = "PauseScene"
    case failed = "FailedScene"
    case characters = "CharactersScene"
}

extension Scenes {
    func getName() -> String {
        let padId = " iPad"
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        
        return isPad ? self.rawValue + padId : self.rawValue
    }
}

enum NodeScale: Float {
    case gameBackgroundScale
}

extension NodeScale {
    
    func getValue() -> Float {
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        
        switch self {
        case .gameBackgroundScale:
            return isPad ? 1.5 : 1.35
        }
    }
}

extension CGPoint {
    init(x: Float, y: Float) {
        self.init()
        self.x = CGFloat(x)
        self.y = CGFloat(y)
    }
}


class GameViewController: UIViewController {

    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sceneName = Scenes.title.getName()
        if let scene = SKScene(fileNamed: sceneName) as? TitleScene {

            scene.scaleMode = .aspectFill
            

            if let view = self.view as! SKView? {
                view.presentScene(scene)
                
                view.ignoresSiblingOrder = true
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
