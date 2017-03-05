//
//  ViewController.swift
//  mobileTambourine
//
//  Created by Dan Reed on 3/5/17.
//  Copyright © 2017 Dan Reed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var soundManager: SoundManager!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup af
    self.soundManager = SoundManager()
    bindToView()
  }

  func bindToView() {
    let tapRecog = UITapGestureRecognizer(target: self, action: #selector(playTambourine))
    self.view.addGestureRecognizer(tapRecog)
  }
  
  func playTambourine() {
    soundManager.playTambourine()
  }
}
