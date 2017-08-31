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
    addRow(type: RowType.oneL)
    
  }
  
  func addRandomRow() {
    let randomNumber = Int(arc4random_uniform(6))
    
    guard let rowType = RowType(rawValue: randomNumber) else { return }
    
    addRow(type: rowType)
    
  }
  
  var lastUpdateTimeInterval = TimeInterval()
  var lastYieldTimeInterval = TimeInterval()
  
  func updateWithTimeSinceLastUpdate(timeSinceLastUpdate: CFTimeInterval) {
    lastYieldTimeInterval += timeSinceLastUpdate
    
    if lastYieldTimeInterval > 0.6 {
      lastYieldTimeInterval = 0
      addRandomRow()
    }
    
  }
  
  
  override func update(_ currentTime: TimeInterval) {
    // Called before each frame is rendered
    
    var timeSinceLastUpdate = currentTime - lastUpdateTimeInterval
    lastUpdateTimeInterval = currentTime
    
    if timeSinceLastUpdate > 1 {
      timeSinceLastUpdate = 1 / 60
      lastUpdateTimeInterval = currentTime
      
    }
    
    updateWithTimeSinceLastUpdate(timeSinceLastUpdate: timeSinceLastUpdate)
    
  }

  
  func didBegin(_ contact: SKPhysicsContact) {
    // BodyA = obstacle; BodyB = player
    if contact.bodyB.node?.name == "PLAYER" {
      showGameOver()
      
    }
  }
  
  func showGameOver() {
    let transition = SKTransition.fade(withDuration: 0.5)
    let gameOverScene = GameOverScene(size: self.size)
    
    self.view?.presentScene(gameOverScene, transition: transition)
    
  }
  
  // MARK: Player movement
  
  func resetPlayerPosition() {
    players[0].position = initialPlayerPos
    players[1].position = initialPlayerPos
    
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    resetPlayerPosition()
  }
  
  // MARK: 3D-TOUCH NEEDED:
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      let maxPossibleForce = touch.maximumPossibleForce
      let force = touch.force
      let normalizedForce = force / maxPossibleForce
      
      players[0].position.x = (self.size.width / 2) - normalizedForce * (self.size.width / 2 - 25)
      players[1].position.x = (self.size.width / 2) + normalizedForce * (self.size.width / 2 - 25)
      
    }
  }
  
  
}
