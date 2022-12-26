//
//  PlaylistViewController.swift
//  GoalSet2
//
//  Created by Christelle F on 5/4/22.
//

import UIKit
import AVFoundation

class PlaylistViewController: UIViewController {

    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //sound effect when each button is pressed
    
    @IBAction func workoutButton(_ sender: Any) {
        do {
            let audioPath = Bundle.main.path(forResource: "TouchSoundEffect", ofType: "mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
        } catch {
            print("Error occurred when playing audio")
        }
    }
    @IBAction func sleepButton(_ sender: Any) {
        do {
            let audioPath = Bundle.main.path(forResource: "TouchSoundEffect", ofType: "mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
        } catch {
            print("Error occurred when playing audio")
        }
    }
    @IBAction func studyButton(_ sender: Any) {
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
        let websiteController = segue.destination as! WebKitViewController
        if segue.identifier == "sleep" {
            websiteController.playlistURL = URL(string: "https://open.spotify.com/playlist/37i9dQZF1DWYcDQ1hSjOpY?si=129b8b0f23994174")
        } else if segue.identifier == "study" {
            websiteController.playlistURL = URL(string: "https://open.spotify.com/playlist/1qECaSnOss1E3Zw87DV71X?si=7c7a685d4a6a4d0f")
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
