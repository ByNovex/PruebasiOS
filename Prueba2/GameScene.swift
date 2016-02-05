//
//  GameScene.swift
//  Prueba2
//
//  Created by Byron Bacusoy Pinela on 5/2/16.
//  Copyright (c) 2016 Byron Bacusoy Pinela. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var flappy = SKSpriteNode()
    
    var backg = SKSpriteNode()
    
    var puntuacion = 0
    
    var labelpuntuacio = SKLabelNode()
    
    var objectosenmovimientos = SKSpriteNode()
    
    enum tipodecolisions: UInt32 {
        case flappy = 1
        //case otros = 2
    }
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.physicsWorld.contactDelegate = self
        
        backg = SKSpriteNode(texture: SKTexture(imageNamed: "black.png"))
        backg.size.width = self.frame.width
        backg.size.height = self.frame.height
        backg.position = CGPointMake(CGRectGetMidX(self.frame), 0 )
        backg.alpha = 0.5
        
        
        self.addChild(backg)
        self.addChild(objectosenmovimientos)
        
        labelpuntuacio.fontName = "Helvetica"
        labelpuntuacio.fontSize = 60
        labelpuntuacio.text = "0"
        labelpuntuacio.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 70)
        self.addChild(labelpuntuacio)
        
        
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("appearRandom"), userInfo: nil, repeats: true)
        

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            for node in self.nodesAtPoint(location){
                if node.position.y <= CGRectGetMidY(self.frame) - CGFloat(flappy.size.height*2){
                    if node.name == "flappy"{
                        node.removeFromParent()
                        puntuacion++
                        labelpuntuacio.text = "\(puntuacion)"
                    }
                }
            }
        }
    }
    
    func appearRandom () {
        var ancho = arc4random() % UInt32(self.frame.size.width)//le restamos el ancho entero.
        comprobrar_posicion(&ancho)
        flappy.physicsBody = SKPhysicsBody(circleOfRadius: flappy.size.height/2)
        flappy.physicsBody!.dynamic = true
        flappy.name = "flappy"
        flappy.physicsBody!.affectedByGravity = false
        flappy.physicsBody!.velocity = CGVectorMake(0 , -175)
        
        flappy.physicsBody!.categoryBitMask = tipodecolisions.flappy.rawValue
        flappy.physicsBody!.collisionBitMask = tipodecolisions.flappy.rawValue
        
        
        let textura = SKTexture(imageNamed:"flappy1.png")
        flappy = SKSpriteNode(texture: textura)
        flappy.position = CGPointMake(CGFloat(ancho + (UInt32(flappy.size.width/2))), CGRectGetMidY(self.frame) + CGFloat(self.frame.height/3))//le sumammos la mitad del ancho
        
        
        
//        var path = CGPathCreateMutable()
//        CGPathMoveToPoint(path, nil, 0, 0)
//        CGPathAddLineToPoint(path, nil, 50, 100)
//        var followLine = SKAction.followPath(path, asOffset: false, orientToPath: false, duration: 3.0)
//        
//        var reversedLine = followLine.reversedAction()
//        
//        var square = UIBezierPath(rect: CGRectMake(0, 0, 100, 100))
//        var followSquare = SKAction.followPath(square.CGPath, asOffset: false, orientToPath: false, duration: 5.0)
//        
//        var circle = UIBezierPath(roundedRect: CGRectMake(0, 0, 100, 100), cornerRadius: 100)
//        var followCircle = SKAction.followPath(circle.CGPath, asOffset: false, orientToPath: false, duration: 5.0)
//        
        
        
        
        objectosenmovimientos.addChild(flappy)
        
        //flappy.runAction(SKAction.sequence([followLine,reversedLine,followSquare,followCircle]))
        
        
    }
    
    func comprobrar_posicion(inout posicion: UInt32){
        if (posicion >= 0 && posicion <= UInt32(flappy.size.width))  || (posicion >= (UInt32(self.frame.size.width) - UInt32(flappy.size.width)) && posicion <= UInt32(self.frame.size.width)) {
            posicion = posicion + UInt32(flappy.size.width/2)
            
        }
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
