//
//  GameOverScene.swift
//  Split Rush
//
//  Created by Daniel Meechan on 31/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(size: CGSize) {
    super.init(size: size)
    
    self.backgroundColor = SKColor.gray
    let message = "GAME OVER"
    
    let label = SKLabelNode(fontNamed: "Optima-ExtraBlack")
    
    label.text = message
    label.fontColor = SKColor.white
    label.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
    
    addChild(label)
    
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let transition = SKTransition.fade(withDuration: 0.5)
    let gameScene = GameScene(size: self.size)
    
    self.view?.presentScene(gameScene, transition: transition)
    
  }
  
}
