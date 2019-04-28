//
//  Level1Scene.swift
//  Final_Project
//
//  Created by Randy Dang on 2018-03-27.
//  Copyright © 2018 Randy Dang. All rights reserved.
//

import UIKit
import SpriteKit

class Level1Scene: SKScene, SKPhysicsContactDelegate {
    
    private var character: SKSpriteNode?
    private var exit: SKSpriteNode?
    private var floor: SKSpriteNode?
    private var projectile: SKSpriteNode?
    private var turret: SKSpriteNode?
    private var wall: SKSpriteNode?
    private var lifeCount: SKLabelNode?
    private var pauseButton: SKSpriteNode?
    private var resumeButton: SKSpriteNode?
    private var endGameButton: SKSpriteNode?
    
    private var lastTouch: CGPoint? = nil
    private let playerSpeed: CGFloat = 8
    private var fingerTouching = true
    private var fingerTouchingJump = false
    private var canJump = true
    private var jumpButton: SKSpriteNode?
    private var screensize = UIScreen.main.bounds
    private let background = SKSpriteNode(imageNamed: "cave2.png")
    private var jumpHeight = 400
    private var initialSize: CGSize?
    private var tempSize: CGSize?
    private var playerPos: String?
    private var flipped: SKTexture?
    private var initialTexture: SKTexture?
    
    private var count = 0
    private var initialCatBM: UInt32?
    private var initialCollBM: UInt32?
    private var initialPosition: CGPoint?
    private var lives = 3
    private var canContact = true
    private var portrait = true
    private var playerPosition: CGPoint?
    private var buttonPosition: CGPoint?
    private var canContact2 = true
    private var jumpRadius: CGSize?
    private var touchSet: Set<UITouch>?
    private var pauseTouched = false
    
    private let ALIVE = "AliveIndex"

    
    override func didMove(to view: SKView) {
        //setting a background
        BackgroundMusic.sharedMusic.playBGMusic(int: 1)
        
         background.zPosition = -20
         background.position = CGPoint(x: 0, y: 0)
         background.size.width = self.size.width
         background.size.height = self.size.height
         background.anchorPoint = CGPoint(x: 0.5,y: 0.5)
         addChild(background)
 
        physicsWorld.contactDelegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(Level1Scene.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        character = childNode(withName: "player") as? SKSpriteNode
        character?.userData?.setObject(true, forKey: ALIVE as NSCopying) //set player as alive
        initialTexture = SKTexture(imageNamed: "player.png")
        flipped = SKTexture(imageNamed: "player2.png")
        initialCatBM = character?.physicsBody?.categoryBitMask
        initialCollBM = character?.physicsBody?.collisionBitMask
        initialPosition = character?.position
  //      print("initial position is \(initialPosition!)")
        
        lifeCount = self.childNode(withName: "label1") as? SKLabelNode

        
        jumpButton = childNode(withName: "jump") as? SKSpriteNode
        jumpRadius = CGSize(width: (jumpButton?.size.width)!/2, height: (jumpButton?.size.height)!)
        pauseButton = childNode(withName: "pause") as? SKSpriteNode
        floor = childNode(withName: "floor") as? SKSpriteNode
        wall = childNode(withName: "wall") as? SKSpriteNode
        exit = childNode(withName: "exit") as? SKSpriteNode
        turret = childNode(withName: "turret") as? SKSpriteNode
        
        initialSize = character?.size
        
        rotated()
        
        updateCamera()
    }
    
    func setScenePause() {
        print("pause game")
        self.isPaused = true
        
        resumeButton = SKSpriteNode(imageNamed: "button_resume.png")
        resumeButton?.position = CGPoint(x: (pauseButton?.position.x)!, y: (pauseButton?.position.y)! - 80)
        resumeButton?.name = "resumeButton"
        resumeButton?.zPosition = 3
        addChild(resumeButton!)
        
        endGameButton = SKSpriteNode(imageNamed: "button_end-game.png")
        endGameButton?.position = CGPoint(x: (pauseButton?.position.x)!, y: (pauseButton?.position.y)! - 150)
        endGameButton?.name = "endGameButton"
        endGameButton?.zPosition = 3
        addChild(endGameButton!)
        pauseTouched = true
        
        
    }

    func endGame() {
        print("Ending game")
        self.isPaused = false
        resumeButton?.removeFromParent()
        endGameButton?.removeFromParent()
        BackgroundMusic.sharedMusic.stopBGMusic()
        let displaySize = UIScreen.main.bounds
        let screenWidth = displaySize.width
        let screenHeight = displaySize.height
        run(SKAction.sequence([
            SKAction.wait(forDuration: 0.3),
            SKAction.run() {
                let winScene = EndGameScene(size: CGSize(width: screenWidth, height: screenHeight))
                let transition = SKTransition.doorway(withDuration: 1.0)
                winScene.scaleMode = .resizeFill
                self.view?.presentScene(winScene, transition: transition)
            }
            ]))
        
    }
 
    
    func updateCamera(){
        guard let character = character else {return}
        camera?.position = character.position
        if portrait == true {
            jumpButton?.position = CGPoint(x: character.position.x, y: character.position.y - 400)
            pauseButton?.position = CGPoint(x: character.position.x, y: character.position.y + 400)
        }
        if portrait == false {
            jumpButton?.position = CGPoint(x: character.position.x, y: character.position.y - 200)
            pauseButton?.position = CGPoint(x: character.position.x, y: character.position.y + 230)
        }
        lifeCount?.position = CGPoint(x: character.position.x, y: character.position.y + 100)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        fingerTouching = true
        let touch = touches.first!
        let location = touch.location(in: self)
        if (self.atPoint(location)).name == jumpButton?.name && fingerTouching && fingerTouchingJump == false && canJump == true{
            
            let jumpUpAction = SKAction.moveBy(x: 0, y: CGFloat(jumpHeight), duration:0.4)
            let jumpSequence = SKAction.sequence([jumpUpAction])
            
            
            character?.run(jumpSequence)
            updateCamera()
            canJump = false
            fingerTouchingJump = true
        }
        
        if (self.atPoint(location)).name == pauseButton?.name && fingerTouching {
            setScenePause()
        
        }
        if (self.atPoint(location)).name == resumeButton?.name && fingerTouching && pauseTouched == true {
            print("unpause")
            self.isPaused = false
            pauseTouched = false
            resumeButton?.removeFromParent()
            endGameButton?.removeFromParent()
        }
        if (self.atPoint(location)).name == endGameButton?.name && fingerTouching && pauseTouched == true {
            pauseTouched = false
            endGame()
        }
        handleTouches(touches)
        

    }
    
    override func touchesMoved(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        fingerTouching = true
        handleTouches(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        fingerTouching = false
        fingerTouchingJump = false
    }
    
    func handleTouches(_ touches: Set<UITouch>) {
        touchSet = touches
        playerPosition = character?.position
        buttonPosition = jumpButton?.position

    }
    
    func updatePlayer() {
        if touchSet == nil{
            return
        }
        for t in touchSet!{
            let character = self.character
            let touch = t.location(in: self)
        

            if (touch.x) > ((playerPosition?.x)! + (jumpRadius?.width)!) && fingerTouching {
  //          print("player position = \(String(describing: playerPosition))")
  //              print("touch position = \(touch.x)")
                playerPos = "RIGHT"
                character?.texture = initialTexture
                
                character?.position.x = (character?.position.x)! + playerSpeed
            updateCamera()
        }
            else if (touch.x) < ((playerPosition?.x)! - (jumpRadius?.width)!) && fingerTouching {
  //          print("player position = \(String(describing: playerPosition))")
  //              print("touch position = \(touch.x)")
                playerPos = "LEFT"
                character?.texture = flipped
                character?.position.x = (character?.position.x)! - playerSpeed
            updateCamera()
        }
        else {
            updateCamera()
            }}
    }
    
    
    override func didSimulatePhysics() {
        count += 1
        if character != nil {
            updatePlayer()
            if count == 200 {
                canContact = true
                canContact2 = true
                turretShoot()
            }
        }
    }
    
    @objc func rotated() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            print("Landscape")
            portrait = false
            jumpHeight = 250
            if playerPos == "LEFT"{
                character?.size.height = (initialSize?.height)! * 0.7
                character?.physicsBody = SKPhysicsBody(texture: flipped!, size: (character?.size)!)
            }
            else if playerPos == "RIGHT"{
                character?.size.height = (initialSize?.height)! * 0.7
                character?.physicsBody = SKPhysicsBody(texture: (character?.texture)!, size: (character?.size)!)
            }
            character?.physicsBody?.allowsRotation = false
            character?.physicsBody?.categoryBitMask = initialCatBM!
            character?.physicsBody?.collisionBitMask = initialCollBM!
        }
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            print("Portrait")
            portrait = true
            jumpHeight = 400
            if playerPos == "LEFT" {
                character?.size.height = (initialSize?.height)!
                character?.physicsBody = SKPhysicsBody(texture: flipped!, size: (character?.size)!)
            }
            else if playerPos == "RIGHT" {
                character?.size.height = (initialSize?.height)!
                character?.physicsBody = SKPhysicsBody(texture: (character?.texture)!, size: (character?.size)!)
            }
            character?.physicsBody?.allowsRotation = false
            character?.physicsBody?.categoryBitMask = initialCatBM!
            character?.physicsBody?.collisionBitMask = initialCollBM!
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // 1. Create local variables for two physics bodies
 //       print("CONTACT")
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
       
        if firstBody.categoryBitMask == character?.physicsBody?.categoryBitMask &&
            secondBody.categoryBitMask == exit?.physicsBody?.categoryBitMask {
            if canContact2 == true {
                playerWon(firstBody.node as! SKSpriteNode, secondBody.node as! SKSpriteNode)
            }
            
        }
        if firstBody.categoryBitMask == character?.physicsBody?.categoryBitMask &&
            secondBody.categoryBitMask == floor?.physicsBody?.categoryBitMask {
         //   print("TOUCHING FLOOR")
            canJump = true
        }
        if firstBody.categoryBitMask == character?.physicsBody?.categoryBitMask &&
            secondBody.categoryBitMask == projectile?.physicsBody?.categoryBitMask {
   //         print("CHARACTER HIT")
            if canContact == true {
                projectileHitPlayer(firstBody.node as! SKSpriteNode, secondBody.node as! SKSpriteNode)
            }
        }
        if firstBody.categoryBitMask == wall?.physicsBody?.categoryBitMask &&
            secondBody.categoryBitMask == projectile?.physicsBody?.categoryBitMask {
            projectileHitWall(firstBody.node as! SKSpriteNode, secondBody.node as! SKSpriteNode)
  //          print("WALL HIT")
        }
        if firstBody.categoryBitMask == character?.physicsBody?.categoryBitMask &&
            secondBody.categoryBitMask == wall?.physicsBody?.categoryBitMask {
    //        print("CHARACTER HIT WALL")
        }
    }
    
    func projectileHitWall(_ wall: SKSpriteNode, _ projectile: SKSpriteNode) {
//        print("projectile hit wall")
        projectile.removeFromParent()
    }
    
    func projectileHitPlayer(_ character: SKSpriteNode, _ projectile: SKSpriteNode){
        print("character got hit")
        canContact = false
        projectile.removeFromParent()
        lives = lives - 1
        lifeCount?.text = "LIVES = \(lives)"
        print("life count = \(lives)")
        if lives == 0 {
            character.userData?.setObject(false, forKey: ALIVE as NSCopying)
            character.removeFromParent()
            BackgroundMusic.sharedMusic.stopBGMusic()
            let displaySize = UIScreen.main.bounds
            let screenWidth = displaySize.width
            let screenHeight = displaySize.height
            run(SKAction.sequence([
                SKAction.wait(forDuration: 0.3),
                SKAction.run() {
                    let loseScene = LoseScene(size: CGSize(width: screenWidth, height: screenHeight))
                    loseScene.scaleMode = .resizeFill
                    let transition = SKTransition.doorway(withDuration: 1.0)
                    self.view?.presentScene(loseScene, transition: transition)
                }
                ]))
        }
    }
    
    func playerWon(_ character: SKSpriteNode, _ exit: SKSpriteNode) {
        print("level completed")
        canContact2 = false
        character.removeFromParent()
        exit.removeFromParent()
        BackgroundMusic.sharedMusic.stopBGMusic()
        let displaySize = UIScreen.main.bounds
        let screenWidth = displaySize.width
        let screenHeight = displaySize.height
        run(SKAction.sequence([
            SKAction.wait(forDuration: 0.3),
            SKAction.run() {
                let winScene = WinScene(size: CGSize(width: screenWidth, height: screenHeight))
                winScene.scaleMode = .resizeFill
                let transition = SKTransition.doorway(withDuration: 1.0)
                self.view?.presentScene(winScene, transition: transition)
            }
            ]))
        
    }
    
    func turretShoot() {
        
        projectile = SKSpriteNode(imageNamed: "projectile.png")
        projectile?.physicsBody = SKPhysicsBody(circleOfRadius: (projectile?.size.width)!/2)
        projectile?.size = CGSize(width: CGFloat((projectile?.frame.width)! * 0.5), height: CGFloat((projectile?.frame.height)! * 0.5))
        projectile?.position.x = (turret?.position.x)! - 10
        projectile?.position.y = (turret?.position.y)!
        projectile?.physicsBody?.affectedByGravity = false
        projectile?.physicsBody?.allowsRotation = true
        projectile?.physicsBody?.isDynamic = true
        projectile?.physicsBody?.categoryBitMask = UInt32(0b1000)
        projectile?.physicsBody?.collisionBitMask = UInt32(0)
        projectile?.physicsBody?.contactTestBitMask = (wall?.physicsBody?.categoryBitMask)! | (character?.physicsBody?.categoryBitMask)!
        projectile?.physicsBody?.usesPreciseCollisionDetection = true
        addChild(projectile!)
        
        // compute the real destination for the projectile
        let realDest = CGPoint(x: self.frame.minX, y: (projectile?.position.y)!)
        
        // 9 - Create the actions
        let actionMove = SKAction.move(to: realDest, duration: 7.0)
        
        let removeAction = SKAction.run() {     //remove the bullet if it misses the invader
            self.projectile?.removeFromParent()
        }
        // if the bullet reaches its destination, you missed the target and lose
        projectile?.run(SKAction.sequence([actionMove,removeAction]))
        count = 0
    }

}
