//
//  Snake.swift
//  Snake
//
//  Created by Артем on 11.04.2018.
//  Copyright © 2018 NONE. All rights reserved.
//

import UIKit
import SpriteKit

class Snake: SKShapeNode {
    var moveSpeed: CGFloat = 155
    var angle: CGFloat = 0
    var body = [SnakeBodyPart]()
    
    convenience init(atPoint point: CGPoint) {
        self.init()
        
        let head = SnakeHead(atPoint: point)
        body.append(head)
        
        addChild(head)
    }
    
    func AddBodyPart() {
        let newBodyPart = SnakeBodyPart(atPoint: CGPoint(x: body[0].position.x, y: body[0].position.y))
        body.append(newBodyPart)
        addChild(newBodyPart)
    }
    
    func Move() {
        guard !body.isEmpty else { return }
        let head = body[0]
        MoveHead(head)
        for index in 0..<body.count where index > 0 {
            let previousBodyPart = body[index - 1]
            let currentBodyPart = body[index]
            MoveBodyPart(previousBodyPart, currentBodyPart)
        }
    }
    
    func MoveBodyPart(_ p: SnakeBodyPart, _ c: SnakeBodyPart) {
        let moveAction = SKAction.move(to: CGPoint(x: p.position.x, y: p.position.y), duration: 0.1)
        c.run(moveAction)
    }
    
    func MoveHead(_ head: SnakeBodyPart) {
        let dx = CGFloat(moveSpeed * sin(angle))
        let dy = CGFloat(moveSpeed * cos(angle))
        let nextPosition = CGPoint(x: head.position.x + dx, y: head.position.y + dy)
        let moveAction = SKAction.move(to: nextPosition, duration: 1.0)
        head.run(moveAction)
    }
    
    func MoveClockWise() {
        angle += CGFloat(Double.pi/2)
    }
    
    func MoveCounterClockWise() {
        angle -= CGFloat(Double.pi/2)
    }
}
