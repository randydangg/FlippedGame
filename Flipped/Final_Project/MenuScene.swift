//
//  MenuScene.swift
//  Final_Project
//
//  Created by Randy Dang on 2018-03-29.
//  Copyright © 2018 Randy Dang. All rights reserved.
//

import UIKit
import SpriteKit

class MenuScene: SKScene {
    var playButton: SKSpriteNode?
    var instruction: SKSpriteNode?
    var playMusic: SKSpriteNode?
    var stopMusic: SKSpriteNode?
    var label: SKLabelNode?
    var logo: SKSpriteNode?
    var count = 0
    
    override init(size: CGSize){
        super.init(size: size)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuScene.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        logo = SKSpriteNode(imageNamed: "logo.png")
        logo?.size = CGSize(width: CGFloat((logo?.frame.width)!*0.8), height: CGFloat((logo?.frame.height)!*0.8))
        logo?.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 110)
        self.addChild(logo!)
        
        playButton = SKSpriteNode(imageNamed: "button_play.png")
        playButton!.name="playButton"
        playButton!.position = CGPoint(x:self.frame.midX, y:self.frame.midY);
        self.addChild(playButton!)
        
        instruction = SKSpriteNode(imageNamed: "button_instructions.png")
        instruction!.name="instruction"
        instruction!.position = CGPoint(x:self.frame.midX, y:self.frame.midY-50);
        self.addChild(instruction!)
        
        count += 1
        rotated()
        
        backgroundColor = SKColor.white
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let theNode = self.atPoint(location)
            
            if theNode.name == playButton!.name {
                print("The \(playButton!.name!) is touched ")
                let transition = SKTransition.moveIn(with: SKTransitionDirection.right, duration: 0.3)
                let scene = LevelScene(size: self.size)
                scene.scaleMode = .resizeFill
                self.view?.presentScene(scene, transition: transition)
            }
            else if theNode.name == instruction!.name{
                print("The \(instruction!.name!) button is touched ")
                let transition = SKTransition.moveIn(with: SKTransitionDirection.right, duration: 0.3)
                let scene = InstructionScene(size: self.size)
                scene.scaleMode = .resizeFill
                self.view?.presentScene(scene, transition: transition)
            }
        }
    }
    
    @objc func rotated() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            print("Landscape")

            if count >= 1 {
                playButton?.removeFromParent()
                logo?.removeFromParent()
                instruction?.removeFromParent()
            }
            
            logo = SKSpriteNode(imageNamed: "logo.png")
            logo?.size = CGSize(width: CGFloat((logo?.frame.width)!*0.8), height: CGFloat((logo?.frame.height)!*0.8))
            logo?.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 110)
            self.addChild(logo!)
            
            playButton = SKSpriteNode(imageNamed: "button_play.png")
            playButton!.name="playButton"
            playButton!.position = CGPoint(x:self.frame.midX, y:self.frame.midY);
            self.addChild(playButton!)
            
            instruction = SKSpriteNode(imageNamed: "button_instructions.png")
            instruction!.name="instruction"
            instruction!.position = CGPoint(x:self.frame.midX, y:self.frame.midY-50);
            self.addChild(instruction!)
            
            count += 1
        }
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            print("Portrait")
            
            if count >= 1 {
                playButton?.removeFromParent()
                logo?.removeFromParent()
                instruction?.removeFromParent()
            }
            
            logo = SKSpriteNode(imageNamed: "logo.png")
            logo?.size = CGSize(width: CGFloat((logo?.frame.width)!*0.8), height: CGFloat((logo?.frame.height)!*0.8))
            logo?.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 110)
            self.addChild(logo!)
            
            playButton = SKSpriteNode(imageNamed: "button_play.png")
            playButton!.name="playButton"
            playButton!.position = CGPoint(x:self.frame.midX, y:self.frame.midY);
            self.addChild(playButton!)
            
            instruction = SKSpriteNode(imageNamed: "button_instructions.png")
            instruction!.name="instruction"
            instruction!.position = CGPoint(x:self.frame.midX, y:self.frame.midY-50);
            self.addChild(instruction!)
            
            count += 1
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
