//
//  InstructionScene.swift
//  Final_Project
//
//  Created by Randy Dang on 2018-03-29.
//  Copyright © 2018 Randy Dang. All rights reserved.
//

import UIKit
import SpriteKit

class InstructionScene: SKScene {
    private var backButton: SKSpriteNode?
    private var label: SKLabelNode?
    private var label2: SKLabelNode?
    private var label3: SKLabelNode?
    private var label4: SKLabelNode?
    private var label5: SKLabelNode?
    private var label6: SKLabelNode?
    private var count = 0
    
    override init(size: CGSize){
        super.init(size: size)
        
        NotificationCenter.default.addObserver(self, selector: #selector(InstructionScene.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        backgroundColor = SKColor.white
        
        //initialize the scene
        label = SKLabelNode(fontNamed: "Courier")
        label?.fontColor = SKColor.black
        label?.fontSize = 29
        label?.text = "INSTRUCTIONS:"
        label?.position =  CGPoint(x:self.frame.midX, y:self.frame.midY+100);
        self.addChild(label!)
        
        label2 = SKLabelNode(fontNamed: "Courier")
        label2?.fontColor = SKColor.black
        label2?.fontSize = 12
        label2?.text = "Reach the exit to win level!"
        label2?.position =  CGPoint(x:self.frame.midX, y:self.frame.midY);
        self.addChild(label2!)
        
        label3 = SKLabelNode(fontNamed: "Courier")
        label3?.fontColor = SKColor.black
        label3?.fontSize = 10
        label3?.text = "Switch to portrait mode to increase player height and jump"
        label3?.position =  CGPoint(x:self.frame.midX, y:self.frame.midY-20);
        self.addChild(label3!)
        
        label4 = SKLabelNode(fontNamed: "Courier")
        label4?.fontColor = SKColor.black
        label4?.fontSize = 10
        label4?.text = "Switch to landscape mode to decrease player height and jump"
        label4?.position =  CGPoint(x:self.frame.midX, y:self.frame.midY-40);
        self.addChild(label4!)
        
        label5 = SKLabelNode(fontNamed: "Courier")
        label5?.fontColor = SKColor.black
        label5?.fontSize = 10
        label5?.text = "Touch left & right side of screen to move"
        label5?.position =  CGPoint(x:self.frame.midX, y:self.frame.midY-60);
        self.addChild(label5!)
        
        label6 = SKLabelNode(fontNamed: "Courier")
        label6?.fontColor = SKColor.black
        label6?.fontSize = 10
        label6?.text = "Touch jump button to jump"
        label6?.position =  CGPoint(x:self.frame.midX, y:self.frame.midY-80);
        self.addChild(label6!)
        
        backButton = SKSpriteNode(imageNamed: "button_back.png")
        backButton!.name="backButton"
        backButton!.position = CGPoint(x:self.frame.midX, y:self.frame.minY+150);
        self.addChild(backButton!)
        
        count += 1
        
        rotated()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let theNode = self.atPoint(location)
            if theNode.name == backButton!.name {
                print("The \(backButton!.name!) is touched ")
                let transition = SKTransition.moveIn(with: SKTransitionDirection.left, duration: 2)
                let scene = MenuScene(size: self.size)
                scene.scaleMode = .resizeFill
                self.view?.presentScene(scene, transition: transition)
            }
        }
    }
    
    @objc func rotated() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            print("Landscape")
            
            if count >= 1 {
                label?.removeFromParent()
                backButton?.removeFromParent()
                label2?.removeFromParent()
                label3?.removeFromParent()
                label4?.removeFromParent()
                label5?.removeFromParent()
                label6?.removeFromParent()
            }
            
            label = SKLabelNode(fontNamed: "Courier")
            label?.fontColor = SKColor.black
            label?.fontSize = 29
            label?.text = "INSTRUCTIONS:"
            label?.position =  CGPoint(x:self.frame.midX, y:self.frame.midY+100);
            self.addChild(label!)
            
            label2 = SKLabelNode(fontNamed: "Courier")
            label2?.fontColor = SKColor.black
            label2?.fontSize = 12
            label2?.text = "Reach the exit to win level!"
            label2?.position =  CGPoint(x:self.frame.midX, y:self.frame.midY);
            self.addChild(label2!)
            
            label3 = SKLabelNode(fontNamed: "Courier")
            label3?.fontColor = SKColor.black
            label3?.fontSize = 10
            label3?.text = "Switch to portrait mode to increase player height and jump"
            label3?.position =  CGPoint(x:self.frame.midX, y:self.frame.midY-20);
            self.addChild(label3!)
            
            label4 = SKLabelNode(fontNamed: "Courier")
            label4?.fontColor = SKColor.black
            label4?.fontSize = 10
            label4?.text = "Switch to landscape mode to decrease player height and jump"
            label4?.position =  CGPoint(x:self.frame.midX, y:self.frame.midY-40);
            self.addChild(label4!)
            
            label5 = SKLabelNode(fontNamed: "Courier")
            label5?.fontColor = SKColor.black
            label5?.fontSize = 10
            label5?.text = "Touch left & right side of screen to move"
            label5?.position =  CGPoint(x:self.frame.midX, y:self.frame.midY-60);
            self.addChild(label5!)
            
            label6 = SKLabelNode(fontNamed: "Courier")
            label6?.fontColor = SKColor.black
            label6?.fontSize = 10
            label6?.text = "Touch jump button to jump"
            label6?.position =  CGPoint(x:self.frame.midX, y:self.frame.midY-80);
            self.addChild(label6!)
            
            backButton = SKSpriteNode(imageNamed: "button_back.png")
            backButton!.name="backButton"
            backButton!.position = CGPoint(x:self.frame.midX, y:self.frame.minY+50);
            self.addChild(backButton!)
            
            count += 1
        }
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            print("Portrait")
            
            if count >= 1 {
                label?.removeFromParent()
                backButton?.removeFromParent()
                label2?.removeFromParent()
                label3?.removeFromParent()
                label4?.removeFromParent()
                label5?.removeFromParent()
                label6?.removeFromParent()
            }
            
            label = SKLabelNode(fontNamed: "Courier")
            label?.fontColor = SKColor.black
            label?.fontSize = 29
            label?.text = "INSTRUCTIONS:"
            label?.position =  CGPoint(x:self.frame.midX, y:self.frame.midY+100);
            self.addChild(label!)
            
            label2 = SKLabelNode(fontNamed: "Courier")
            label2?.fontColor = SKColor.black
            label2?.fontSize = 12
            label2?.text = "Reach the exit to win level!"
            label2?.position =  CGPoint(x:self.frame.midX, y:self.frame.midY);
            self.addChild(label2!)
            
            label3 = SKLabelNode(fontNamed: "Courier")
            label3?.fontColor = SKColor.black
            label3?.fontSize = 10
            label3?.text = "Switch to portrait mode to increase player height and jump"
            label3?.position =  CGPoint(x:self.frame.midX, y:self.frame.midY-20);
            self.addChild(label3!)
            
            label4 = SKLabelNode(fontNamed: "Courier")
            label4?.fontColor = SKColor.black
            label4?.fontSize = 10
            label4?.text = "Switch to landscape mode to decrease player height and jump"
            label4?.position =  CGPoint(x:self.frame.midX, y:self.frame.midY-40);
            self.addChild(label4!)
            
            label5 = SKLabelNode(fontNamed: "Courier")
            label5?.fontColor = SKColor.black
            label5?.fontSize = 10
            label5?.text = "Touch left & right side of screen to move"
            label5?.position =  CGPoint(x:self.frame.midX, y:self.frame.midY-60);
            self.addChild(label5!)
            
            label6 = SKLabelNode(fontNamed: "Courier")
            label6?.fontColor = SKColor.black
            label6?.fontSize = 10
            label6?.text = "Touch jump button to jump"
            label6?.position =  CGPoint(x:self.frame.midX, y:self.frame.midY-80);
            self.addChild(label6!)
            
            backButton = SKSpriteNode(imageNamed: "button_back.png")
            backButton!.name="backButton"
            backButton!.position = CGPoint(x:self.frame.midX, y:self.frame.minY+150);
            self.addChild(backButton!)
            
            count += 1
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
