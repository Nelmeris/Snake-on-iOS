//
//  GameScene.swift
//  Snake
//
//  Created by Artem Kufaev on 11.04.2018.
//  Copyright © 2018 Artem Kufaev. All rights reserved.
//

import SpriteKit
import GameplayKit

struct CollisionCategories {
    static let Snake: UInt32 = 0x1 << 0
    static let SnakeHead: UInt32 = 0x1 << 1
    static let Apple: UInt32 = 0x1 << 2
    static let EdgeBody: UInt32 = 0x1 << 3
}

class GameScene: SKScene {
    var snake: Snake?
    var apple: Apple?
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        physicsBody?.collisionBitMask = CollisionCategories.Snake | CollisionCategories.SnakeHead
        physicsBody?.allowsRotation = false
        
        view.showsPhysics = true
        
        //Кнопка поворота по часовой стрелке
        let counterClockwiseButton = SKShapeNode()
        
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX + 30, y: view.scene!.frame.minY + 30)
        
        counterClockwiseButton.fillColor = .gray
        counterClockwiseButton.strokeColor = .gray
        counterClockwiseButton.lineWidth = 10
        counterClockwiseButton.name = "counterClockwiseButton"
        
        addChild(counterClockwiseButton)
        
        let сlockWiseButton = SKShapeNode()
        
        сlockWiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        сlockWiseButton.position = CGPoint(x: view.scene!.frame.maxX - 75, y: view.scene!.frame.minY + 30)
        
        сlockWiseButton.fillColor = .gray
        сlockWiseButton.strokeColor = .gray
        сlockWiseButton.lineWidth = 10
        сlockWiseButton.name = "clockWiseButton"
        
        addChild(сlockWiseButton)
        
        createApple()
        
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        
        addChild(snake!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode,
                touchedNode.name == "counterClockwiseButton" || touchedNode.name == "clockWiseButton" else {
                return
            }
            if touchedNode.name == "counterClockwiseButton" {
                snake!.MoveCounterClockWise()
            } else if touchedNode.name == "clockWiseButton" {
                snake!.MoveClockWise()
            }
            touchedNode.fillColor = .green
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode,
                touchedNode.name == "counterClockwiseButton" || touchedNode.name == "clockWiseButton" else {
                return
            }
            touchedNode.fillColor = .gray
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        snake!.Move()
    }
    
    func createApple() {
        let x = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX - 15)) + 10)
        let y = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY - 100)) + 90)
        
        apple = Apple(position: CGPoint(x: x, y: y))
        
        addChild(apple!)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let bodies = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let collisionObject = bodies ^ CollisionCategories.SnakeHead
        
        switch collisionObject {
        case CollisionCategories.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake?.AddBodyPart()
            apple?.removeFromParent()
            createApple()
        case CollisionCategories.EdgeBody:
            snake?.removeFromParent()
            snake = Snake(atPoint: CGPoint(x: view!.scene!.frame.midX, y: view!.scene!.frame.midY))
            addChild(snake!)
            apple?.removeFromParent()
            createApple()
        default:
            break
        }
    }
}
