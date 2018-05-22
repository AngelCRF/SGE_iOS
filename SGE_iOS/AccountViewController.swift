//
//  AccountViewController.swift
//  SGE_iOS
//
//  Created by Kevin Angel on 25/02/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import Foundation
import UIKit

class AccountViewController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func CerrarButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(false,forKey:"isUserLoggedIn");
        UserDefaults.standard.synchronize();
        self.performSegue(withIdentifier: "logoutSegue", sender: self);
    }
}

