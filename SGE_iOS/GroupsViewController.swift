//
//  GroupsViewController.swift
//  SGE_iOS
//
//  Created by Carlos Villanueva on 15/06/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import UIKit

struct group: Decodable {
    var nombre_completo_materia:String = ""
    var id:Int = 0
    var grupo:String = ""
    
    func getName()->String{
        return self.nombre_completo_materia;
    }
    func getCL()->String{
        return String(nombre_completo_materia.prefix(1));
    }
    func getId()->Int{
        return self.id;
    }
    
}

class GroupsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "groupCell", for: indexPath) as! GroupsCollectionViewCell
        cell.name?.text = groups?[indexPath.item].getName()
        cell.capitalLetter?.text = groups?[indexPath.item].getCL()
        cell.view?.backgroundColor = colors[randomNumer()]
        cell.view?.layer.cornerRadius = 35
        return cell
    }
    

    var groups:[group]?
    let colors = [UIColor.init(hexString: "#dddbf1"), UIColor.init(hexString: "#e0ecfa"), UIColor.init(hexString: "#eeecf2"), UIColor.init(hexString: "#c9eaf6"), UIColor.init(hexString: "#cec9e8"), UIColor.init(hexString: "#e1ebc4"), UIColor.init(hexString: "#f1eee3"), UIColor.init(hexString: "#f9e8c9")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "grupos", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do{
            let data = try Data(contentsOf: url)
            //let myJson = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
            groups = try JSONDecoder().decode([group].self, from: data)
        }
        catch {
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randomNumer()->Int{
        let num = Int(arc4random_uniform(UInt32(colors.count)))
        return num
    }


}
