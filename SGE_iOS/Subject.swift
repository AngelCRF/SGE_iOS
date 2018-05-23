//
//  Subject.swift
//  SGE_iOS
//
//  Created by Carlos Villanueva on 20/05/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import Foundation

class Subject{
    var name:String = ""
    var schedule = [String]()
    
    
    init(name:String, schedule:[String]){
        self.name = name
        self.schedule = schedule
    }
    
    func getScheduleDay(day:Int)->String{
        return schedule[day]
    }
    
    func getName()->String{
        return self.name
    }
    
}
