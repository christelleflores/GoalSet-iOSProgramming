//
//  WebVideoViewController.swift
//  GoalSet2
//
//  Created by Christelle F on 5/9/22.
//

import UIKit
import WebKit

class WebVideoViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var videoURL = URL(string: "https://www.youtube.com/watch?v=L4N1q4RNi9I")
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    //swipe out of the video
    @IBAction func swipeRight(_ sender: Any) {
        print("swipe right gesture")
        navigationController?.popViewController(animated: true)
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlRequest = URLRequest(url: videoURL!)
        webView.load(urlRequest)
        
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
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
