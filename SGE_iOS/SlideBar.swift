//
//  SlideBar.swift
//  SGE_iOS
//
//  Created by Carlos Villanueva on 08/02/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import UIKit

class SlideBar: UIViewController {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var leadingConst: NSLayoutConstraint!
    var menu:Bool = false
    @IBOutlet weak var slideView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowRadius = 6
    }
    
    @IBAction func showMenu(_ sender: Any) {
        if (menu){
            leadingConst.constant = -160;
        }
        else{
            leadingConst.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        menu = !menu
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
