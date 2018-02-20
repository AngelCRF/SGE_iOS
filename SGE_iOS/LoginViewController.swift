//
//  ViewController.swift
//  SGE_iOS
//
//  Created by Kevin Angel on 04/02/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var ControlNoText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var panel: UIView!
    @IBOutlet weak var TNImage: UIImageView!
    @IBOutlet weak var ITMImage: UIImageView!
    
    @IBAction func logInBtn(_ sender: Any) {
        let userNoControl = ControlNoText.text;
        let userPassword = passwordText.text;
        
        if("13121005" == userNoControl){
            if("13121005" == userPassword){
                // Login is successfull
                UserDefaults.standard.set(true,forKey:"isUserLoggedIn");
                UserDefaults.standard.synchronize();
                self.dismiss(animated: true, completion:nil);
            }
        }
        
        //var access:Bool = false
        //TODO acceso al usuario
        //if(access){
            // let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
           //  let newViewController = storyBoard.instantiateViewController(withIdentifier: "NavController") as! UINavigationController
          //  self.present(newViewController, animated: true, completion: nil)
       // }
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInButton.layer.cornerRadius = 5
        panel.layer.cornerRadius = 5
        TNImage.image = UIImage(named:"tnm")
        ITMImage.image = UIImage(named:"logo_it")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

