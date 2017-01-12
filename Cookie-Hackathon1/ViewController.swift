//
//  ViewController.swift
//  Cookie-Hackathon1
//
//  Created by Stefanie Fluin on 1/12/17.
//  Copyright © 2017 Stefanie Fluin. All rights reserved.
//


// velocity = distance/time
// distance = velocity x time
// Acceleration is the change in velocity over time
// accel = vel / time
//velocity = accell * time
// interval = start to stop



import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var startStopButton: UIButton!
    
    var startTime = Date()
    var time: Double = 0.0
    var acceleration: Double = 0.0
    var velocity: Double = 0.0
    var distance: Double = 0.0
    
    var motionManager: CMMotionManager?
    
    @IBAction func startButtonPressedDown(_ sender: UIButton) {
        sender.backgroundColor = UIColor.red
        startStopButton.setTitle("Stop", for: .normal)
        resetVariables()
        startTime = Date()
        print("startime: \(startTime)")
        motionManager = CMMotionManager()
        if let manager = motionManager {
            let myQ = OperationQueue()
            manager.deviceMotionUpdateInterval = 1
            //            if didStart {
            manager.startDeviceMotionUpdates(to: myQ) {
                (data:CMDeviceMotion?, error: Error?) in
                if let myData = data {
                    self.acceleration = myData.userAcceleration.x
//                    print("acceleration-x", acceleration.x)
                }
            }
        }
    }
    
    @IBAction func stopButtonPressedUp(_ sender: UIButton) {
        startStopButton.setTitle("Start", for: .normal)
        motionManager?.stopDeviceMotionUpdates()
        time = Double(Date().timeIntervalSince(startTime))
        print("time difference: \(time)")
        calculateDistance()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func resetVariables() {
        velocity = 0.0
        distance = 0.0
        acceleration = 0.0
        time = 0.0
    }
    
    func degrees(radians: Double) -> Double {
        return 180 / Double.pi * radians
    }
    
    func calculateDistance() {
        print("accel \(acceleration)")
        print("time \(time)")
        if acceleration < 0 {
            acceleration *= -1
        }
        print("accel2 \(acceleration)")
        velocity = Double(acceleration) * time
        print("velocity \(velocity)")
        let rawDistance = velocity * time * 9.8 * 39.37 // 1.10159 m/s2 43.369 in/s2
        distance = rawDistance.squareRoot()
        print("dist \(distance) inches")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

