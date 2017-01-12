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
// interval = start to stop



import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var startStopButton: UIButton!
    
    var motionManager: CMMotionManager?
    
    @IBAction func startButtonPressedDown(_ sender: UIButton) {
    }
    
    @IBAction func stopButtonPressedUp(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        motionManager = CMMotionManager()
        if let manager = motionManager {
            let myQ = OperationQueue()
            manager.deviceMotionUpdateInterval = 1
            manager.startDeviceMotionUpdates(to: myQ) {
                (data:CMDeviceMotion?, error: Error?) in
                if let myData = data {
                    let acceleration = myData.userAcceleration
                    print("acceleration-x", acceleration.x)
                }
            }
        }
    }
    
    func degrees(radians: Double) -> Double {
        return 180 / Double.pi * radians
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

