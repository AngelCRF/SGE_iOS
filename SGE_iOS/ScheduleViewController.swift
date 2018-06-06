//
//  ScheduleViewController.swift
//  SGE_iOS
//
//  Created by Carlos Villanueva on 19/05/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import UIKit

struct subject: Decodable {
    var name:String = ""
    var schedule = [String]()
    
    /* Not usefull with swift 4
    enum CodingKeys : String, CodingKey {
        case name
        case schedule
    }
     */

    func getScheduleDay(day:Int)->String{
        return String(schedule[day].split(separator: " ")[1] + schedule[day].split(separator: " ")[2])
    }
    
    func getName()->String{
        return self.name
    }
}

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate{
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections![section].expanded = !sections![section].expanded
        tableView.beginUpdates()
        for i in 0 ..< sections![section].subjects.count{
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
    var sections:[Section]?
    var subjects: [subject]?
    
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationItem.title = "Horario"
        
        //nuevo
        let path = Bundle.main.path(forResource: "subjecttest", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do{
            let data = try Data(contentsOf: url)
            //let myJson = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
            subjects = try JSONDecoder().decode([subject].self, from: data)
            //print(myJson)
        }
        catch {
            
        }
        
        let lunes = Section(day: "lunes", subjects: daySchedule(day: 0), expanded: false )
        let martes = Section(day: "Martes", subjects: daySchedule(day: 1), expanded: false )
        let miercoles = Section(day: "Miércoles", subjects: daySchedule(day: 2), expanded: false )
        sections = [lunes, martes, miercoles]
        
        //Viejo
        /*
        let calculo = Subject(name:"cálculo", schedule: ["8:00 F5", "8:00 F5","8:00 F5","8:00 F5","8:00 F5"])
        let matematicas = Subject(name:"Matemáticas Dis", schedule: ["9:00 F5", "9:00 F5","9:00 F5","9:00 F5","9:00 F5"])
        //creación de secciones
        //proximo avance: metodo para crear el string de subjects enviando el día que se quiere consultar (0-6)
        
        let lunes = Section(day: "lunes", subjects: [calculo.getName()+" "+calculo.getScheduleDay(day: 0),
                                                     matematicas.getName()+" "+matematicas.getScheduleDay(day: 1)], expanded: false )
        let martes = Section(day: "Martes", subjects: [calculo.getName()+" "+calculo.getScheduleDay(day: 0),
                                                      matematicas.getName()+" "+matematicas.getScheduleDay(day: 1)], expanded: false )
        let miercoles = Section(day: "Miércoles", subjects: [calculo.getName()+" "+calculo.getScheduleDay(day: 2),matematicas.getName()+" "+matematicas.getScheduleDay(day: 2)], expanded: false )
        
        sections = [lunes, martes, miercoles]
        */
        
    }
    
    func daySchedule(day : Int) -> [String]{
        var chain = [String]()
        for sub in subjects!{
            chain.append(sub.getName() + " " + sub.getScheduleDay(day: day))
        }
        return chain
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return (sections!.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections![section].subjects.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(sections![indexPath.section].expanded){
            return 44
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections![section].day, section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell")
        cell?.textLabel?.text = sections![indexPath.section].subjects[indexPath.row]
        return cell!
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
