//
//  SettingTableViewController.swift
//  SGE_iOS
//
//  Created by Carlos Villanueva on 07/07/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var userSemester: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        getDataFromUrl(url: url) { data, response, error in guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.profileImage.image = UIImage(data: data)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 30
        
        
        let id = UserDefaults.standard.string(forKey: "loggedUser")
        //Obtener imagen de URL y Nombre del alumno.
        if let url = URL(string:"https://sge.morelia.tecnm.mx/storage/data/alumnos/\(String(describing: id))/foto.jpg") {
            downloadImage(url: url)
            } else {
            profileImage.image = #imageLiteral(resourceName: "pony")
        }
        
        //userName.text = ******nombre de usuario con id ******
        
        
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
