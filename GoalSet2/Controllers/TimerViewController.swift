//
//  TimerViewController.swift
//  GoalSet2
//
//  Created by Christelle F on 5/8/22.
//

//animation video reference: https://www.youtube.com/watch?v=gAHYXM2e5E0

import UIKit
import NotificationCenter

class TimerViewController: UIViewController {


    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startTimerButton: UIButton!
    
    let shape = CAShapeLayer()
    var timer = Timer()
    var second = 60
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create animation
        let circlePath = UIBezierPath(arcCenter: view.center, radius: 150, startAngle: -(.pi / 2), endAngle: .pi * 2, clockwise: true)
        
        let trackShape = CAShapeLayer()
        trackShape.path = circlePath.cgPath
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.lineWidth = 15
        trackShape.strokeColor = UIColor.lightGray.cgColor
        view.layer.addSublayer(trackShape)
        
        shape.path = circlePath.cgPath
        shape.lineWidth = 15
        shape.strokeColor = UIColor.green.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeEnd = 0
        view.layer.addSublayer(shape)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {success, error in }
        
    }
    
    //display animation
    @IBAction func startTimer() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 75
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        shape.add(animation, forKey: "animation")
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerTick), userInfo: nil, repeats: true)
    }
    
    //double tap to start timer
    @IBAction func tapToStart(_ sender: Any) {
        startTimer()
    }
    
    @IBAction func stopTimer(_ sender: Any) {
        timer.invalidate()
    }
    
    //start timer and send notifications
    @objc func timerTick() {
        second -= 1
        timerLabel.text = "00:\(second)"
        
        if second == 0 {
            let notifyUser = UNMutableNotificationContent()
            notifyUser.title = "GoalSet Timer"
            notifyUser.body = "Time is up!"
            notifyUser.sound = .defaultCritical
            let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let uniqueID = UNNotificationRequest(identifier: UUID().uuidString, content: notifyUser, trigger: (timeTrigger))
            UNUserNotificationCenter.current().add(uniqueID, withCompletionHandler: nil)
            timer.invalidate()
        } else if second <= 0 {
            timer.invalidate()
        }
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
