//
//  Section.swift
//  SGE_iOS
//
//  Created by Carlos Villanueva on 20/05/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import Foundation

struct Section {
    var day: String!
    var subjects: [String]!
    var expanded: Bool!
    
    init(day: String, subjects: [String], expanded: Bool) {
        self.day = day
        self.subjects = subjects
        self.expanded = expanded
    }
}
