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
    var professor:String = ""
    var schedule = [String]()
    
    /* Not usefull with swift 4
    enum CodingKeys : String, CodingKey {
        case name
        case schedule
    }
     */

    func getScheduleDay(day:Int)->String{
        return "\(schedule[day].split(separator: " ")[1]) \(schedule[day].split(separator: " ")[2]) \t\(schedule[day].split(separator: " ")[3])"
    }
    
    func getName()->String{
        return self.name
    }
    func getProfessor()->String{
        return self.professor
    }
}

class subTableViewCell: UITableViewCell {
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var professorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
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
        }
        catch {
            
        }
        
        let lunes = Section(day: "Lunes", subjects: daySchedule(day: 0), expanded: false )
        let martes = Section(day: "Martes", subjects: daySchedule(day: 1), expanded: false )
        let miercoles = Section(day: "Miércoles", subjects: daySchedule(day: 2), expanded: false )
        sections = [lunes, martes, miercoles]
    }
    
    func daySchedule(day : Int) -> [String]{
        var chain = [String]()
        for sub in subjects!{
            chain.append(sub.getName() + "\n" + sub.getProfessor() + "\n" + sub.getScheduleDay(day: day))
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
            return 85
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! subTableViewCell
        //cell?.textLabel?.numberOfLines = 0;
        //cell?.textLabel?.lineBreakMode = .byWordWrapping
        //self.contentView.backgroundColor = UIColor(hexString: "#5c1423")
        cell.subjectLabel?.text = String (sections![indexPath.section].subjects[indexPath.row].split(separator: "\n")[0])
        cell.professorLabel?.text = String (sections![indexPath.section].subjects[indexPath.row].split(separator: "\n")[1])
        cell.timeLabel?.text = String (sections![indexPath.section].subjects[indexPath.row].split(separator: "\n")[2])
        return cell
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
    
   


