//
//  LevelScene.swift
//  Final_Project
//
//  Created by Randy Dang on 2018-03-29.
//  Copyright © 2018 Randy Dang. All rights reserved.
//

import UIKit
import SpriteKit

class LevelScene: SKScene {
    private var backButton: SKSpriteNode?
    private var levelSelect: SKSpriteNode?
    private var level1: SKSpriteNode?
    private var level2: SKSpriteNode?
    private var tutorial: SKSpriteNode?
    private var count = 0
    
    override init(size: CGSize){
        super.init(size: size)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LevelScene.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        backgroundColor = SKColor.black
        
        levelSelect = SKSpriteNode(imageNamed: "levelSelect.png")
        levelSelect?.size = CGSize(width: CGFloat((levelSelect?.frame.width)!*0.4), height: CGFloat((levelSelect?.frame.height)!*0.4))
        levelSelect?.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 50)
        self.addChild(levelSelect!)
        
        backButton = SKSpriteNode(imageNamed: "button_back")
        backButton!.name="backButton"
        backButton!.position = CGPoint(x:self.frame.midX, y:self.frame.minY+100);
        self.addChild(backButton!)
        
        level1 = SKSpriteNode(imageNamed: "button.png")
        level1!.name = "level1"
        level1!.position = CGPoint(x: self.frame.minX+50, y: self.frame.maxY-250)
        self.addChild(level1!)
        
        level2 = SKSpriteNode(imageNamed: "button (1).png")
        level2!.name = "level2"
        level2!.position = CGPoint(x: self.frame.minX+150, y: self.frame.maxY-250)
        self.addChild(level2!)
        
        tutorial = SKSpriteNode(imageNamed: "button_play-tutorial.png")
        tutorial!.name = "tutorial"
        tutorial!.position = CGPoint(x: self.frame.midX, y: self.frame.maxY-150)
        self.addChild(tutorial!)
        
        count += 1
        rotated()
        
        
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let theNode = self.atPoint(location)
            if theNode.name == backButton!.name {
                print("The \(backButton!.name!) is touched ")
                let transition = SKTransition.moveIn(with: SKTransitionDirection.left, duration: 0.3)
                let scene = MenuScene(size: self.size)
                scene.scaleMode = .resizeFill
                self.view?.presentScene(scene, transition: transition)
            }
            if theNode.name == tutorial!.name {
                print("The \(tutorial!.name!) is touched ")
                let transition = SKTransition.moveIn(with: SKTransitionDirection.left, duration: 1)
                let scene = SKScene(fileNamed: "Tutorial")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: transition)
            }
            if theNode.name == level1!.name {
                print("The \(level1!.name!) is touched ")
                let transition = SKTransition.moveIn(with: SKTransitionDirection.left, duration: 1)
                let scene = SKScene(fileNamed: "MyScene")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: transition)
            }
            if theNode.name == level2!.name {
                print("The \(level2!.name!) is touched ")
                let transition = SKTransition.moveIn(with: SKTransitionDirection.left, duration: 1)
                let scene = SKScene(fileNamed: "Level2")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: transition)
            }
            
        }
    }
    
    @objc func rotated() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            print("Landscape")
            
            if count >= 1 {
                levelSelect?.removeFromParent()
                backButton?.removeFromParent()
                level1?.removeFromParent()
                level2?.removeFromParent()
                tutorial?.removeFromParent()
            }
            
            levelSelect = SKSpriteNode(imageNamed: "levelSelect.png")
            levelSelect?.size = CGSize(width: CGFloat((levelSelect?.frame.width)!*0.4), height: CGFloat((levelSelect?.frame.height)!*0.4))
            levelSelect?.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 50)
            self.addChild(levelSelect!)
            
            backButton = SKSpriteNode(imageNamed: "button_back")
            backButton!.name="backButton"
            backButton!.position = CGPoint(x:self.frame.midX, y:self.frame.minY+50);
            self.addChild(backButton!)
            
            level1 = SKSpriteNode(imageNamed: "button.png")
            level1!.name = "level1"
            level1!.position = CGPoint(x: self.frame.minX+50, y: self.frame.maxY-200)
            self.addChild(level1!)
            
            level2 = SKSpriteNode(imageNamed: "button (1).png")
            level2!.name = "level2"
            level2!.position = CGPoint(x: self.frame.minX+150, y: self.frame.maxY-200)
            self.addChild(level2!)
            
            tutorial = SKSpriteNode(imageNamed: "button_play-tutorial.png")
            tutorial!.name = "tutorial"
            tutorial!.position = CGPoint(x: self.frame.midX, y: self.frame.maxY-120)
            self.addChild(tutorial!)
            
            count += 1
        }
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            print("Portrait")
            
            if count >= 1 {
                levelSelect?.removeFromParent()
                backButton?.removeFromParent()
                level1?.removeFromParent()
                level2?.removeFromParent()
                tutorial?.removeFromParent()
            }
            
            levelSelect = SKSpriteNode(imageNamed: "levelSelect.png")
            levelSelect?.size = CGSize(width: CGFloat((levelSelect?.frame.width)!*0.4), height: CGFloat((levelSelect?.frame.height)!*0.4))
            levelSelect?.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 50)
            self.addChild(levelSelect!)
            
            backButton = SKSpriteNode(imageNamed: "button_back")
            backButton!.name="backButton"
            backButton!.position = CGPoint(x:self.frame.midX, y:self.frame.minY+100);
            self.addChild(backButton!)
            
            level1 = SKSpriteNode(imageNamed: "button.png")
            level1!.name = "level1"
            level1!.position = CGPoint(x: self.frame.minX+50, y: self.frame.maxY-250)
            self.addChild(level1!)
            
            level2 = SKSpriteNode(imageNamed: "button (1).png")
            level2!.name = "level2"
            level2!.position = CGPoint(x: self.frame.minX+150, y: self.frame.maxY-250)
            self.addChild(level2!)
            
            tutorial = SKSpriteNode(imageNamed: "button_play-tutorial.png")
            tutorial!.name = "tutorial"
            tutorial!.position = CGPoint(x: self.frame.midX, y: self.frame.maxY-150)
            self.addChild(tutorial!)
            
            count += 1
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
