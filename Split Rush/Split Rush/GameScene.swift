//
//  GameScene.swift
//  Split Rush
//
//  Created by Daniel Meechan on 31/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  
  var players = [SKSpriteNode]()
  var initialPlayerPos: CGPoint = CGPoint()
  
  override func didMove(to view: SKView) {
    self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    physicsWorld.contactDelegate = self
    addPlayers()
    addRow(type: RowType.twoS)
    
  }
  
  
  override func update(_ currentTime: TimeInterval) {
    // Called before each frame is rendered
  }
  
}
