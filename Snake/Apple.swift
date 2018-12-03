//
//  Apple.swift
//  Snake
//
//  Created by Артем on 11.04.2018.
//  Copyright © 2018 NONE. All rights reserved.
//

import UIKit
import SpriteKit

class Apple : SKShapeNode {
    convenience init(position: CGPoint) {
        self.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        fillColor = .green
        strokeColor = .green
        lineWidth = 5
        self.position = position
        
        physicsBody = SKPhysicsBody(circleOfRadius: 10, center: CGPoint(x: 5, y: 5))
        physicsBody?.categoryBitMask = CollisionCategories.Apple
    }
}
