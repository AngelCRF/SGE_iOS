//
//  AccoutOptionsViewController.swift
//  SGE_iOS
//
//  Created by Carlos Villanueva on 14/06/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import UIKit

class AccoutOptionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell" ) as! AccountOptionTableViewCell
        cell.cellText.text = options[indexPath.row]
        cell.cellImage.image = UIImage(named: img[indexPath.row])
        cell.view.layer.cornerRadius = cell.view.frame.height / 2
        return cell
    }
    
    
    let options = ["Mi horario", "Configuracion", "Cerrar sesión"]
    let img = ["calendar-icon", "settings", "logout"]
    var index = 0;
    
    @IBOutlet var profileName: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableOptions: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 90
        self.navigationItem.title = ""
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        switch index {
        case 0:
            performSegue(withIdentifier: "scheduleSegue", sender: self)
        //case 1:
        case 2:
            UserDefaults.standard.set(false,forKey:"isUserLoggedIn");
            UserDefaults.standard.synchronize();
            self.tabBarController?.selectedIndex = 0
        default:
            index=0;
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
