//
//  ViewController.swift
//  SGE_iOS
//
//  Created by Kevin Angel on 04/02/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ControlNoText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var panel: UIView!
    @IBOutlet weak var TNImage: UIImageView!
    @IBOutlet weak var ITMImage: UIImageView!
    
    @IBAction func logInBtn(_ sender: Any) {
        var access:Bool = false
        //TODO acceso al usuario
        access = true
        if(access){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            //let newViewController = storyBoard.instantiateViewController(withIdentifier: "RevealViewController") as! SWRevealViewController
            //self.present(newViewController, animated: true, completion: nil)
        }
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

