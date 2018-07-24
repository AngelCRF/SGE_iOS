//
//  PostCell.swift
//  SGE_iOS
//
//  Created by Kevin Angel on 10/02/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import Foundation
import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var PostidLabel: UILabel!
    @IBOutlet weak var PostLabel: UILabel!
    @IBOutlet weak var PostImageImageView: UIImageView!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var OriginLabel: UILabel!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var ProfileImageView: UIImageView!
    @IBOutlet weak var NCommentsLabel: UILabel!
    
    var id: String!
    var post: NewsfeedTableViewController.Post!{
        didSet{
            self.updateUI()
        }
    }
    
    func updateUI(){
        if let url = URL(string: (post.createdBy?.profileImage)!) {
            downloadImage(url: url)
        } else {
            ProfileImageView.image = #imageLiteral(resourceName: "pony")
        }
        PostidLabel.text=post.id_post
        UserNameLabel.text = post.createdBy?.username
        TimeLabel.text = post.date
        OriginLabel.text = post.group
        PostLabel.text = post.caption
        PostImageImageView.downloadedFrom(link: post.image!)
        if (post.image != "" ) {
            PostImageImageView.downloadedFrom(link: post.image!)
        } else {
            PostImageImageView.image = nil
            PostImageImageView.frame.size.height = 1.0
        }
        if (post.comments.count==0){
            NCommentsLabel.text = "Sin Comentarios"
        } else if (post.comments.count==1){
            NCommentsLabel.text = "\(post.comments.count) Comentario"
        } else {
            NCommentsLabel.text = "\(post.comments.count) Comentarios"
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        getDataFromUrl(url: url) { data, response, error in guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                    self.ProfileImageView.image = UIImage(data: data)
            }
        }
    }
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
