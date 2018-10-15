//
//  GameScene.swift
//  Game01
//
//  Created by Henrik Wirth on 15.10.18.
//  Copyright © 2018 Henrik Wirth. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var vivi = SKSpriteNode()
    private var viviWalkingFrames: [SKTexture] = []
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        buildVivi()
        animateVivi()
    }
    
    func buildVivi() {
        let sheet=SpriteSheet(texture: SKTexture(imageNamed: "Vivi"), rows: 6, columns: 6, spacing: 0, margin: 0)
  
//        for r in 0...5 {
//            for c in 0...5 {
//                viviWalkingFrames.append(sheet.textureForColumn(column: c, row: r)!)
//            }
//        }
        
        viviWalkingFrames.append(sheet.textureForColumn(column: 3, row: 4)!)
        viviWalkingFrames.append(sheet.textureForColumn(column: 4, row: 4)!)
        viviWalkingFrames.append(sheet.textureForColumn(column: 5, row: 4)!)

        
        let firstFrameTexture = viviWalkingFrames[0]
        vivi = SKSpriteNode(texture: firstFrameTexture)
        vivi.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(vivi)
        
        print(viviWalkingFrames)
    }
    func animateVivi() {
        vivi.run(SKAction.repeatForever(
            SKAction.animate(with: viviWalkingFrames,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
                 withKey:"walkingInPlaceVivi")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        moveVivi(location: location)
    }
    
    func viviMoveEnded() {
        vivi.removeAllActions()
    }
    
    func moveVivi(location: CGPoint) {
        // 1
        var multiplierForDirection: CGFloat
        
        // 2
        let viviSpeed = frame.size.width / 3.0
        
        // 3
        let moveDifference = CGPoint(x: location.x - vivi.position.x, y: location.y - vivi.position.y)
        let distanceToMove = sqrt(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y)
        
        // 4
        let moveDuration = distanceToMove / viviSpeed
        
        // 5
        if moveDifference.x < 0 {
            multiplierForDirection = 1.0
        } else {
            multiplierForDirection = -1.0
        }
        vivi.xScale = abs(vivi.xScale) * multiplierForDirection
        
        // 1
        if vivi.action(forKey: "walkingInPlaceVivi") == nil {
            // if legs are not moving, start them
            animateVivi()
        }
        
        // 2
        let moveAction = SKAction.move(to: location, duration:(TimeInterval(moveDuration)))
        
        // 3
        let doneAction = SKAction.run({ [weak self] in
            self?.viviMoveEnded()
        })
        
        // 4
        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
        vivi.run(moveActionWithDone, withKey:"viviMoving")
    }

    
//
//    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
//    }
//
//    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
//    }
//
//    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
//        if (self.lastUpdateTime == 0) {
//            self.lastUpdateTime = currentTime
//        }
//
//        // Calculate time since last update
//        let dt = currentTime - self.lastUpdateTime
//
//        // Update entities
//        for entity in self.entities {
//            entity.update(deltaTime: dt)
//        }
//
//        self.lastUpdateTime = currentTime
    }
}
