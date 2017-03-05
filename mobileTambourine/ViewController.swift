//
//  ViewController.swift
//  mobileTambourine
//
//  Created by Dan Reed on 3/5/17.
//  Copyright © 2017 Dan Reed. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MotionManagerDelegate {
  var soundManager: SoundManager!
  var motionManager: MotionManager!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup af
    self.soundManager = SoundManager()
    self.motionManager = MotionManager()
    motionManager.delegate = self
    bindToView()
  }

  func bindToView() {
    let tapRecog = UITapGestureRecognizer(target: self, action: #selector(playTambourine))
    self.view.addGestureRecognizer(tapRecog)
  }
  
  func playTambourine() {
    soundManager.playTambourine()
  }
  
  func phoneWasShaken() {
    playTambourine()
  }
}
