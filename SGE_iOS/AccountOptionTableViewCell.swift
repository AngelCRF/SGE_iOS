//
//  AccountOptionTableViewCell.swift
//  SGE_iOS
//
//  Created by Carlos Villanueva on 19/05/18.
//  Copright © 2018 KEAM. All rights reserved.
//

import UIKit

class AccountOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
