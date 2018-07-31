//
//  ViewController.swift
//  SGE_iOS
//
//  Created by Kevin Angel on 04/02/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox

class LoginViewController: UIViewController {

    @IBOutlet weak var controlNoText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func logInBtn(_ sender: Any) {
        
        let userNoControl = controlNoText.text
        let userPassword = passwordText.text
        
        if(validateUserAndPassword(User: userNoControl!,Password: userPassword!)){
            UserDefaults.standard.set(true,forKey:"isUserLoggedIn")
            UserDefaults.standard.set(userNoControl!,forKey:"loggedUser")
            UserDefaults.standard.synchronize()
            errorLabel.text = ""
            self.dismiss(animated: true, completion:nil)
        } else {
            errorLabel.text = "Error, favor de verificar los datos"
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            LoginViewController.shake(view: logoImage)
            LoginViewController.shake(view: controlNoText)
            LoginViewController.shake(view: passwordText)
            LoginViewController.shake(view: logInButton)
            passwordText.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImage.image = UIImage(named:"pony")
        logInButton.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func validateUserAndPassword(User:String, Password:String)-> Bool{
        let users: [[String]] = [["13121005", "140995"], ["14121110", "123456"], ["14121167", "123456"],["", ""]]
        var flag = false
        for i in 1...users.count {
            if (User == users[i-1][0] && Password == users[i-1][1]){
                flag = true
                break
            } else {
                flag = false
            }
        }
        return flag
    }
    
    static func shake(view: UIView, for duration: TimeInterval = 0.5, withTranslation translation: CGFloat = 10) {
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            view.transform = CGAffineTransform(translationX: translation, y: 0)
        }
        propertyAnimator.addAnimations({view.transform = CGAffineTransform(translationX: 0, y: 0)}, delayFactor: 0.2)
        propertyAnimator.startAnimation()
    }
}
