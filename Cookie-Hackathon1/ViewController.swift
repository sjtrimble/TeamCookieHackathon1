//
//  ViewController.swift
//  Cookie-Hackathon1
//
//  Created by Team Cookie - Coding Dojo on 1/12/17.
//  Copyright © 2017 Team Cookie - Codjing Dojo. All rights reserved.
//  Developers: Stefanie Fluin, June Yoshii, Calvin Nguyen, Michael Imgrund
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var distanceResultLabel: UILabel!
    
    var startTime = Date()
    var time: Double = 0.0
    var acceleration: Double = 0.0
    var startAcceleration: Double = 0.0
    var velocity: Double = 0.0
    var distance: Double = 0.0
    var numberOfReadings: Double = 0.0
//    let myBlue = UIColor (red:53/255.0, green:169/255.0, blue:255/255.0, alpha:1.0)
    let myRed = UIColor (red:208/255.0, green:2/255.0, blue:27/255.0, alpha:1.0)

    
    @IBOutlet weak var appNameLabel: UIButton!
    
    var motionManager: CMMotionManager?
    
    @IBAction func resestHomePressed(_ sender: UIButton) {
        distanceResultLabel.isHidden = true
        resetVariables()
    }
    
    @IBAction func startButtonPressedDown(_ sender: UIButton) {
        sender.backgroundColor = myRed
        startStopButton.setTitle("Release to Stop", for: .normal)
        distanceResultLabel.isHidden = true
        resetVariables()
        var firstReading: Double = 7777777.77
        var buttonStartTime = Date()
//        print("startime: \(startTime)")
        motionManager = CMMotionManager()
        if let manager = motionManager {
            let myQ = OperationQueue()
            manager.deviceMotionUpdateInterval = 0.1
            manager.startDeviceMotionUpdates(to: myQ) {
                (data:CMDeviceMotion?, error: Error?) in
                if let myData = data {
                    self.acceleration = myData.userAcceleration.x * 9.8 // converting to m/s2
                    // zero measures after count is greater than 1
                    if self.acceleration > 0.04 || self.numberOfReadings > 0 {
                        firstReading = self.acceleration
                        if self.acceleration < 0 {
                            self.acceleration *= -1
                        }
                        if self.acceleration == Double(firstReading ){
                            self.startTime = Date()
                        }
                        print("acceleration-x", self.acceleration)
                        self.velocity = (self.acceleration * 0.1) + self.velocity
                        self.numberOfReadings += 1.0
                        print("total velocity from readings\(self.velocity)")
                    }
                }
            }
        }
    }
    
    @IBAction func stopButtonPressedUp(_ sender: UIButton) {
        startStopButton.setTitle("Press to Start", for: .normal)
        sender.backgroundColor = UIColor.black
        distanceResultLabel.backgroundColor = UIColor.black
        distanceResultLabel.isHidden = false
        motionManager?.stopDeviceMotionUpdates()
        time = Double(Date().timeIntervalSince(startTime))
//        print("time difference: \(time)")
        calculateDistance()
        if distance > 0 {
            distanceResultLabel.text = String(Double(round(distance * 100)/100)) + " in"
        } else {
            distanceResultLabel.text = "Try Again :)"
        }
        distanceResultLabel.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appNameLabel.setTitle("Measure Ninja", for: .normal)
        appNameLabel.backgroundColor = UIColor.black
        distanceResultLabel.isHidden = true
    }
    
    func resetVariables() {
        velocity = 0.0
        distance = 0.0
        acceleration = 0.0
        time = 0.0
        startTime = Date()
    }
    
    func degrees(radians: Double) -> Double {
        return 180 / Double.pi * radians
    }
    
    func calculateDistance() {
//        print("accel \(acceleration)")
//        print("time \(time)")
//        print("accel2 \(acceleration)")
        print("average velocity \(velocity)")
        velocity = velocity / numberOfReadings
//        velocity = Double(acceleration) * time
//        print("velocity \(velocity)")
        let rawDistance = velocity * time * 39.37 // converting to in/s2
        distance = rawDistance.squareRoot()
//        print("dist \(distance) inches")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

