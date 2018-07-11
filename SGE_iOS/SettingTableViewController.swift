//
//  SettingTableViewController.swift
//  SGE_iOS
//
//  Created by Carlos Villanueva on 07/07/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 30
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        dayLabel.text = formatter.string(from: date)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 2 && indexPath.row == 0) {
            UserDefaults.standard.set(false,forKey:"isUserLoggedIn");
            UserDefaults.standard.synchronize();
            self.tabBarController?.selectedIndex = 0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
