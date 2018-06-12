//
//  ViewController.swift
//  SGE_iOS
//
//  Created by Kevin Angel on 04/02/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var controlNoText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func logInBtn(_ sender: Any) {
        
        let userNoControl = controlNoText.text;
        let userPassword = passwordText.text;
        
        if(validateUserAndPassword(User: userNoControl!,Password: userPassword!)){
            // Login is successfull
            UserDefaults.standard.set(true,forKey:"isUserLoggedIn");
            UserDefaults.standard.synchronize();
            errorLabel.text = ""
            self.dismiss(animated: true, completion:nil);
        } else {
            errorLabel.text = "Error, favor de verificar los datos"
            LoginViewController.shake(view: logoImage)
            LoginViewController.shake(view: controlNoText)
            LoginViewController.shake(view: passwordText)
            LoginViewController.shake(view: logInButton)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImage.image = UIImage(named:"pony")
        logInButton.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validateUserAndPassword(User:String, Password:String)-> Bool{
        //Function to simulate a validation this need to change to the API validation returning a bool
        let users: [[String]] = [["13121005", "140995"], ["14121110", "123456"], ["14121167", "123456"]]
        var flag = false
        for i in 1...3 {
            if (User == users[i-1][0] && Password == users[i-1][1]){
                flag = true
                break
            }
            else {
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
