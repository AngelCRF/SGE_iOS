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

    @IBOutlet weak var ControlNoText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var TNImage: UIImageView!
    @IBOutlet weak var ITMImage: UIImageView!
    
    @IBAction func logInBtn(_ sender: Any) {
        
        let userNoControl = ControlNoText.text;
        let userPassword = passwordText.text;
        
        if(validateUserAndPassword(User: userNoControl!,Password: userPassword!)){
            // Login is successfull
            UserDefaults.standard.set(true,forKey:"isUserLoggedIn");
            UserDefaults.standard.synchronize();
            self.dismiss(animated: true, completion:nil);
        } else {
            showToast(message: "Error favor de verificar los datos")
        }
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TNImage.image = UIImage(named:"tnm")
        ITMImage.image = UIImage(named:"logo_it")
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
    
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 120, y: self.view.frame.size.height-100, width: 250, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(
            withDuration: 4.0,
            delay: 0.1,
            options: .curveEaseOut,
            animations: {toastLabel.alpha = 0.0},
            completion: {(isCompleted) in toastLabel.removeFromSuperview()}
        )
    }
}

