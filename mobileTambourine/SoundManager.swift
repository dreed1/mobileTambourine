//
//  SoundManager.swift
//  Quickdraw Duelers
//
//  Created by Dan Reed on 5/4/15.
//  Copyright (c) 2015 Dan Reed. All rights reserved.
//

import UIKit
import AVFoundation

class Sound: NSObject {
  var maxPolyphony: Int = 5
  var filename: String = ""
  var soundBank = [AVAudioPlayer]()
  
  var currentSound: Int = 0
  
  init(filename: String, maxPolyphony: Int) {
    super.init()
    
    self.maxPolyphony = maxPolyphony
    self.filename = filename
    for _ in 0..<self.maxPolyphony {
      soundBank.append(self.createSnd())
    }
  }
  
  func createSnd() -> AVAudioPlayer {
    let sndUrl = URL(
      fileURLWithPath:
      Bundle.main.path(
        forResource: self.filename,
        ofType: "wav"
        )!
    )
    print(sndUrl)
    
    do {
      try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
    } catch _ {
    }
    do {
      try AVAudioSession.sharedInstance().setActive(true)
    } catch _ {
    }
    
    var error:NSError?
    let snd: AVAudioPlayer!
    do {
      snd = try AVAudioPlayer(contentsOf: sndUrl)
    } catch let error1 as NSError {
      error = error1
      snd = nil
    }
    snd.prepareToPlay()
    
    return snd
  }
  
  func play() {
    self.soundBank[currentSound].play()
    self.currentSound = (self.currentSound + 1) % self.maxPolyphony
  }
}

class SoundManager: NSObject {
  var tambourineSound: Sound!
  
  override init() {
    super.init()
    
    self.initSounds()
  }
  
  func initSounds() {
    self.tambourineSound = Sound(filename: "tambourine", maxPolyphony: 20)
  }
  
  func playSoundWithName(_ name:String) {
    DispatchQueue.main.async(execute: { [weak self] () -> Void in
      switch(name) {
      case "tambourine":
        self?.tambourineSound.play()
      default:
        print("\(name) is not a valid sound right now.")
      }
      })
  }
  
  func playTambourine() {
    self.playSoundWithName("tambourine")
  }
}
