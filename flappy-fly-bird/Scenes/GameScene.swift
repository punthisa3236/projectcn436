//
//  GameScene.swift
//  ios-spritekit-flappy-flying-bird
//
//  Created by Tham Thearawiboon on 22/11/2564 BE.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    

    
    static var viewportSize: CGSize = .zero
    

    
    lazy var stateMachine: GKStateMachine = GKStateMachine(states: [
        PlayingState(adapter: sceneAdapeter!),
        GameOverState(scene: sceneAdapeter!),
        PausedState(scene: self, adapter: sceneAdapeter!)
        ])
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    let maximumUpdateDeltaTime: TimeInterval = 1.0 / 60.0

    var sceneAdapeter: GameSceneAdapter?
    let selection = UISelectionFeedbackGenerator()


    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        self.lastUpdateTime = 0
        sceneAdapeter = GameSceneAdapter(with: self)
        sceneAdapeter?.stateMahcine = stateMachine
        sceneAdapeter?.stateMahcine?.enter(PlayingState.self)
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        GameScene.viewportSize = view.bounds.size
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sceneAdapeter?.touchables.forEach({ touchable in
            touchable.touchesBegan(touches, with: event)
        })
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        sceneAdapeter?.touchables.forEach { touchable in
            touchable.touchesMoved(touches, with: event)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        sceneAdapeter?.touchables.forEach { touchable in
            touchable.touchesEnded(touches, with: event)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        sceneAdapeter?.touchables.forEach { touchable in
            touchable.touchesCancelled(touches, with: event)
        }
    }
    

    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        guard view != nil else { return }
        
        var deltaTime = currentTime - lastUpdateTime
        
        deltaTime = deltaTime > lastUpdateTime ? maximumUpdateDeltaTime : deltaTime
        
        lastUpdateTime = currentTime

        if self.isPaused { return }
        
        stateMachine.update(deltaTime: deltaTime)

        sceneAdapeter?.updatables.filter({ return $0.shouldUpdate }).forEach({ (activeUpdatable) in
            activeUpdatable.update(currentTime)
        })
    }
}


// MARK: - Conformance to ButtonNodeResponderType
extension GameScene: ButtonNodeResponderType {
    
    func buttonTriggered(button: ButtonNode) {
        guard let identifier = button.buttonIdentifier else {
            return
        }
        selection.selectionChanged()
        
        switch identifier {
        case .pause:
            sceneAdapeter?.stateMahcine?.enter(PausedState.self)
        case .resume:
            sceneAdapeter?.stateMahcine?.enter(PlayingState.self)
        case .home:
            let sceneId = Scenes.title.getName()
            guard let gameScene = GameScene(fileNamed: sceneId) else {
                return
            }
            gameScene.scaleMode = RoutingUtilityScene.sceneScaleMode
            let transition = SKTransition.fade(withDuration: 1.0)
            transition.pausesIncomingScene = false
            transition.pausesOutgoingScene = false
            self.view?.presentScene(gameScene, transition: transition)
        case .retry:
            sceneAdapeter?.stateMahcine?.enter(PlayingState.self)
        default:
            debugPrint("Cannot be executed from here")
            
        }
    }
}
