//
//  SlideBar.swift
//  SGE_iOS
//
//  Created by Carlos Villanueva on 08/02/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import UIKit

class SlideBar: UIViewController {
    
    var menu:Bool = false
    
    @IBOutlet weak var slideBarView: UIView!
    
    @IBOutlet weak var leadingConst: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        slideBarView.layer.shadowOpacity = 1
        slideBarView.layer.shadowRadius = 6
    }
    
    func colorWithAlphaComponent(alpha: CGFloat) -> UIColor{
        let newColor = UIColor.init(red: 0.5, green: 0.8, blue: 1.0, alpha: alpha)
        return newColor
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
