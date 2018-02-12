//
//  PostCell.swift
//  SGE_iOS
//
//  Created by Kevin Angel on 10/02/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import Foundation
import UIKit

class PostCell : UITableViewCell {
    
    @IBOutlet weak var PostLabel: UILabel!
    @IBOutlet weak var PostImageImageView: UIImageView!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var OriginLabel: UILabel!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var ProfileImageView: UIImageView!
    @IBOutlet weak var NCommentsLabel: UILabel!
    @IBOutlet weak var ShowButton: UIButton!
    
    var post : Post!{
        didSet{
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        ProfileImageView.image = post.createdBy.profileImage
        UserNameLabel.text = post.createdBy.username
        TimeLabel.text = post.timeAgo
        PostLabel.text = post.caption
        PostImageImageView.image = post.image
        NCommentsLabel.text = "\(post.numberOfComments!) Comments"
    }
}
