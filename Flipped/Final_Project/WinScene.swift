//
//  WinScene.swift
//  Final_Project
//
//  Created by Randy Dang on 2018-03-31.
//  Copyright © 2018 Randy Dang. All rights reserved.
//

import UIKit
import SpriteKit

class WinScene: SKScene {
    override init(size: CGSize){
        super.init(size: size)
        backgroundColor = SKColor.black
        
        let label = SKLabelNode(fontNamed: "Courier")
        label.fontColor = SKColor.white
        label.fontSize = 29
        label.text = "Level Completed!"
        label.position =  CGPoint(x:self.frame.midX, y:self.frame.midY+100);
        self.addChild(label)
        
        let label2 = SKLabelNode(fontNamed: "Courier")
        label2.fontColor = SKColor.white
        label2.fontSize = 18
        label2.text = "Returning to Level Select"
        label2.position =  CGPoint(x:self.frame.midX, y:self.frame.midY);
        self.addChild(label2)
        
        _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(LoseScene.updateView), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func updateView() {
        let scene = LevelScene(size: self.size)
        scene.scaleMode = .resizeFill
        let transition = SKTransition.doorway(withDuration: 1.0)
        self.view?.presentScene(scene, transition: transition)
    }
}
