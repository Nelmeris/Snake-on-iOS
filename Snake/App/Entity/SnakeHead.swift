//
//  SnakeHead.swift
//  Snake
//
//  Created by Artem Kufaev on 11.04.2018.
//  Copyright © 2018 Artem Kufaev. All rights reserved.
//

import UIKit
import SpriteKit

class SnakeHead: SnakeBodyPart {
    override init(atPoint point: CGPoint) {
        super.init(atPoint: point)
        
        physicsBody?.categoryBitMask = CollisionCategories.SnakeHead
        physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Apple | CollisionCategories.Snake
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
}
