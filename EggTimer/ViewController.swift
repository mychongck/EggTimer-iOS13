//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player :AVAudioPlayer!
    var ckTimer = Timer()
    // Define count down seconds, and remaining time tracker
    let eggTime = ["Soft": 300, "Medium": 420,"Hard": 720]
    // let eggTime = ["Soft": 5, "Medium": 10, "Hard": 15]
    var secondPassed = 0
    var secondRemaining = 0
    var ckTotalEggTime  = 0
    
    @IBOutlet weak var ckDisplayLabel: UILabel!
    @IBOutlet weak var ckProgressView: UIProgressView!

    
    @IBAction func selected(_ sender: UIButton) {
  
        ckTimer.invalidate()    // kill the previous running timer
        ckProgressView.progress = 0.0    // reset progress view to 1 (0.0 to 1.0)
        secondPassed = 0

        
        // get the seconds from Dictionary
        let ckLabel = sender.titleLabel?.text
        print("\(String(describing: ckLabel)) \(eggTime[ckLabel!]) ")
        ckTotalEggTime = eggTime[ckLabel!]!
        secondRemaining = ckTotalEggTime
        print ("Total Time = \(ckTotalEggTime)")

        // Set a timer
        // Every 1.0 second interval, call my function, repeat this
        ckTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ckFunction), userInfo: nil, repeats: true)
        
    }
    
    @objc func ckFunction () {
        
        if secondPassed < ckTotalEggTime {
            
            // Track the counters
            secondPassed += 1
            secondRemaining -= 1
            
            // Manage progress bar
            let ckPercentage = Float(secondPassed) / Float(ckTotalEggTime)
            ckProgressView.progress = Float(ckPercentage)
            
            // Manage time remaining
             ckDisplayLabel.text = "\(secondRemaining) Seconds"
            

        } else {
            
            ckTimer.invalidate()
            ckDisplayLabel.text = "Done!"
            
            // Play Ding sound
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
                    
        }
    }

}
