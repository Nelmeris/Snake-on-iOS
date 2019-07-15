//
//  GameViewController.swift
//  Snake
//
//  Created by Artem Kufaev on 11.04.2018.
//  Copyright © 2018 Artem Kufaev. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.bounds.size)
        
        self.view = SKView(frame: view.bounds)
        
        let scView = view as! SKView
        
        scView.ignoresSiblingOrder = true
        
        scene.scaleMode = .resizeFill
        
        scView.presentScene(scene)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
