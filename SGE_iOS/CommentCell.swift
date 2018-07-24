//
//  CommentCell.swift
//  SGE_iOS
//
//  Created by Kevin Angel on 12/07/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import Foundation
import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet weak var userImageComentImageView: UIImageView!
    @IBOutlet weak var timeCommentLabel: UILabel!
    @IBOutlet weak var userCommnetLabel: UILabel!
    @IBOutlet weak var CommentLabel: UILabel!
    
    var comment: NewsfeedTableViewController.Comment!{
        didSet {
            self.updateUI()
        }
    }
    
    
    func updateUI(){
        let data = try? Data(contentsOf: URL(string:(comment.createdBy?.profileImage)!)!)
        if let imageData = data {
            let image = UIImage(data: imageData)
            userImageComentImageView.image = image
        } else {
            userImageComentImageView.image = #imageLiteral(resourceName: "pony")
        }
        //timeCommentLabel.text=comment.time
        userCommnetLabel.text = comment.createdBy?.username
        CommentLabel.text = comment.comment
    }
}
