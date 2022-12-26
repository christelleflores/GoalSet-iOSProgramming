//
//  WebKitViewController.swift
//  GoalSet2
//
//  Created by Christelle F on 5/4/22.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var playlistURL = URL(string: "https://open.spotify.com/playlist/4wJJY7tYsrxhHGpGYuJo7K?si=0fd422b4e810471c")
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    @IBAction func swipeGesture(_ sender: Any) {
        print("swipe right gesture")
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlRequest = URLRequest(url: playlistURL!)
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
