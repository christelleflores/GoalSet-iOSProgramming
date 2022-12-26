//
//  VideoViewController.swift
//  GoalSet2
//
//  Created by Christelle F on 5/9/22.
//

import UIKit
import AVFoundation

class VideoViewController: UIViewController {

    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //audio plays sound effect when you tap each button
    
    @IBAction func whatGoalVideo(_ sender: Any) {
        do {
            let audioPath = Bundle.main.path(forResource: "TouchSoundEffect", ofType: "mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
        } catch {
            print("Error occurred when playing audio")
        }
    }
    
    @IBAction func motivationVideo(_ sender: Any) {
        do {
            let audioPath = Bundle.main.path(forResource: "TouchSoundEffect", ofType: "mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
        } catch {
            print("Error occurred when playing audio")
        }
    }
    
    @IBAction func inspiringQuotesVideo(_ sender: Any) {
        do {
            let audioPath = Bundle.main.path(forResource: "TouchSoundEffect", ofType: "mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
        } catch {
            print("Error occurred when playing audio")
        }
    }
    
    // segues video to one web view depending on button pressed
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let websiteController = segue.destination as! WebVideoViewController
        if segue.identifier == "motivation" {
            websiteController.videoURL = URL(string: "https://www.youtube.com/watch?v=gURbukjLSjk")
        } else if segue.identifier == "quotes" {
            websiteController.videoURL = URL(string: "https://www.youtube.com/watch?v=naRoUFi3JXA")
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

