//
//  SnakeBodyPart.swift
//  Snake
//
//  Created by Artem Kufaev on 11.04.2018.
//  Copyright © 2018 Artem Kufaev. All rights reserved.
//

import UIKit
import SpriteKit

class SnakeBodyPart: SKShapeNode {
    let diameter = 10.0
    
    init(atPoint point: CGPoint) {
        super.init()
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: CGFloat(diameter), height: CGFloat(diameter))).cgPath
        fillColor = .black
        strokeColor = .black
        lineWidth = 5
        
        position = point
        
        physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(diameter - 4), center: CGPoint(x: 5, y:5))
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = CollisionCategories.Snake
        physicsBody?.collisionBitMask = CollisionCategories.EdgeBody | CollisionCategories.Apple | CollisionCategories.Snake
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
}
