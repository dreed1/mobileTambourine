//
//  MotionManager.swift
//  mobileTambourine
//
//  Created by Dan Reed on 3/5/17.
//  Copyright © 2017 Dan Reed. All rights reserved.
//

import UIKit
import CoreMotion
import Foundation

protocol MotionManagerDelegate {
  func phoneWasShaken()
}

class MotionManager: NSObject {
  var manager: CMMotionManager!
  var delegate: MotionManagerDelegate?
  
  var phoneIsShaken: Bool = false
  
  override init() {
    super.init()
    
    self.manager = CMMotionManager()
    initAccelerometer()
  }
  
  func initAccelerometer() {
    let shakeThreshold = 1.5
    if manager.isAccelerometerAvailable {
      manager.accelerometerUpdateInterval = 0.01
      manager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: {
        [weak self] (data: CMAccelerometerData?, error: Error?) in
        if let acceleration = data?.acceleration {
          let x = acceleration.x
          let y = acceleration.y
          let z = acceleration.z
          if x > shakeThreshold || y > shakeThreshold || z > shakeThreshold {
            NSLog("phone was shaken")
            self?.debouncePhoneShake()
          }
        }
      })
    } else {
      NSLog("Oh I can't get to the accel updates.")
    }
  }
  
  func debouncePhoneShake() {
    if !phoneIsShaken {
      self.delegate?.phoneWasShaken()
      phoneIsShaken = true
      self.perform(#selector(phoneIsNotBeingShaken), with: self, afterDelay: 0.2)
    }
    
  }
  
  func phoneIsNotBeingShaken() {
    phoneIsShaken = false
  }
}
