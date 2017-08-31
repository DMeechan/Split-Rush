//
//  GameViewController.swift
//  Split Rush
//
//  Created by Daniel Meechan on 31/08/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController, AVAudioPlayerDelegate {
  
  var audioPlayer = AVAudioPlayer()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let view = self.view as! SKView? {
      // Load the SKScene from 'GameScene.sks'
      if let scene = SKScene(fileNamed: "GameScene") {
        // Start playing background music
        
        playSound(audioFileName: "bgMusic")
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        // Present the scene
        view.presentScene(scene)
      }
      
      view.ignoresSiblingOrder = true
      
      view.showsFPS = true
      view.showsNodeCount = true
    }
  }
  
  func playSound(audioFileName: String) {
    if let sound = NSDataAsset(name: audioFileName) {
      do {
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try! AVAudioSession.sharedInstance().setActive(true)
        
        try audioPlayer = AVAudioPlayer(data: sound.data)
        
        // Loop forever
        audioPlayer.numberOfLoops = -1
        
        audioPlayer.play()
        
        audioPlayer.delegate = self
        
      } catch {
        print("Error playing sound: \(audioFileName)")
      }
    }
    
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
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}
