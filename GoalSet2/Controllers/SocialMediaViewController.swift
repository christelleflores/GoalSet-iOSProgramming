//
//  SocialMediaViewController.swift
//  GoalSet2
//
//  Created by Christelle F on 5/4/22.
//

import UIKit
import Social

class SocialMediaViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let camera = UIImagePickerController()
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        camera.delegate = self
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        camera.allowsEditing = false
        camera.sourceType = .camera
        camera.cameraCaptureMode = .photo
        camera.modalPresentationStyle = .fullScreen
        present(camera, animated: true, completion: nil)
        print("photo taken")
    }
    
    @IBAction func facebookPost(_ sender: Any) {
        print("preping facebook post")
        let facebookPostText = "Accomplishing my goals GoalSet! Download this cool app today!"
        let facebookPostImage = imageView.image
        let facebookController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        facebookController?.setInitialText(facebookPostText)
        facebookController?.add(facebookPostImage)
        
        self.present(facebookController!, animated: true, completion: nil)
        print("post made")
    }
    
    @IBAction func twitterPost(_ sender: Any) {
        print("preping twitter post")
        let twitterPostText = "Accomplishing my goals GoalSet! Download this cool app today!"
        let twitterPostImage = imageView.image
        let twitterController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        twitterController?.setInitialText(twitterPostText)
        twitterController?.add(twitterPostImage)
        
        self.present(twitterController!, animated: true, completion: nil)
        print("post made")
    }
   
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var chosenImage = UIImage()
        chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = chosenImage
        dismiss(animated: true, completion: nil)
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
