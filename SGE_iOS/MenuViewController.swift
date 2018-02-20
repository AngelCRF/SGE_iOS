//
//  MenuViewController.swift
//  SGE_iOS
//
//  Created by Carlos Villanueva on 10/02/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    var menuNameArr:Array = [String]()
    var iconeImage:Array = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
        menuNameArr = ["Mis Grupos", "Muro", "Chat"]
        iconeImage  = [UIImage(named:"post")!, UIImage(named:"group")!, UIImage(named:"group")!]
        
        imgProfile.layer.borderColor = UIColor.red.cgColor
        imgProfile.image = UIImage(named:"profilePic")!
        imgProfile.layer.borderWidth = 2
        //imgProfile.layer.cornerRadius = 50
        imgProfile.layer.masksToBounds = false
        imgProfile.clipsToBounds = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuNameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        cell.imgIcon.image = iconeImage[indexPath.row]
        cell.lblMenuName.text = menuNameArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let revealViewController:SWRevealViewController = self.revealViewController()
        let cell:MenuTableViewCell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        
        switch cell.lblMenuName.text! {
        case "Mis Grupos":
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "MisGrupos") as! WallViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        case "Muro":
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            //cambiar el identificador y tipo de controlador
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "Muro") as! WallViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        case "Chat":
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            //cambiar el identificador y tipo de controlador
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "ViewControler") as! WallViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        default:
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "MisGrupos") as! ViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
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
