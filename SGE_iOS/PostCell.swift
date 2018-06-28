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
    
    var id: String!
    var post : NewsfeedTableViewController.Post!{
        didSet{
            self.updateUI()
        }
    }
    
    func updateUI(){
        
        let data = try? Data(contentsOf: URL(string:(post.createdBy?.profileImage)!)!)
        if let imageData = data {
            let image = UIImage(data: imageData)
            ProfileImageView.image = image
        } else {
            ProfileImageView.image = #imageLiteral(resourceName: "icon_user")
        }
        UserNameLabel.text = post.createdBy?.username
        TimeLabel.text = post.date
        OriginLabel.text = post.group
        PostLabel.text = post.caption
        
        if (post.image != nil) {
            if let _ = Bundle.main.path(forResource: "imageName", ofType: "jpg"), let image = UIImage(contentsOfFile: post.image!) {
                PostImageImageView.image = image
            } else {
            PostImageImageView.image = nil
            PostImageImageView.frame.size.height = 1.0
            }
        } else {
            PostImageImageView.image = nil
            PostImageImageView.frame.size.height = 1.0
        }
        NCommentsLabel.text = "\(post.comments.count) Comments"
    }
}
