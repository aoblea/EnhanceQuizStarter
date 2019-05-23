//
//  SoundManager.swift
//  EnhanceQuizStarter
//
//  Created by Arwin Oblea on 5/23/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import AudioToolbox

class SoundManager {
  var gameSound: SystemSoundID = 0
  
  func loadGameStartSound() {
    let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
    let soundUrl = URL(fileURLWithPath: path!)
    AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
  }
  
  func playGameStartSound() {
    AudioServicesPlaySystemSound(gameSound)
  }
}
