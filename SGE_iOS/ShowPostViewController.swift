//
//  ShowPostViewController.swift
//  SGE_iOS
//
//  Created by Kevin Angel on 16/06/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import Foundation
import UIKit

class ShowPostViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var userimageImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var imagePostImageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var CommentsTableView: UITableView!
    
    var userImage: String!
    var user: String!
    var origin: String!
    var time: String!
    var caption: String!
    var imagePost: String!
    var refresher: UIRefreshControl!
    var commentsshowed: [NewsfeedTableViewController.Comment] = Array()
    var limit = 1
    var totalEnteries: Int!
    
    var post : NewsfeedTableViewController.Post!
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor(hexString: "#dc9c03")
        commentTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboradWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboradWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboradWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        updateUI()
        
        refresher = UIRefreshControl()
        //refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(NewsfeedTableViewController.populateTableView), for: UIControlEvents.valueChanged)
        CommentsTableView.dataSource = self
        CommentsTableView.delegate = self
        CommentsTableView.addSubview(refresher)
    }
    
    @objc func populateTableView() {
        totalEnteries = post.comments.count
        commentsshowed.removeAll()
        var index = 0
        while index < limit {
            commentsshowed.append(post.comments[index])
            index = index + 1
        }
        self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
        refresher.endRefreshing()
    }
    
    func updateUI(){
        if let url = URL(string: (post.createdBy?.profileImage)!) {
            downloadImage(url: url)
        } else {
            userimageImageView.image = #imageLiteral(resourceName: "pony")
        }
        //PostidLabel.text=post.id_post
        userLabel.text = post.createdBy?.username
        timeLabel.text = post.date
        originLabel.text = post.group
        captionLabel.text = post.caption
        
        if (post.image != "" ) {
            imagePostImageView.downloadedFrom(link: post.image!)
        } else {
            imagePostImageView.image = nil
            imagePostImageView.frame.size.height = 1.0
        }
        //NCommentsLabel.text = "\(post.comments.count) Comments"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
    func hideKeyboard(){
        commentTextField.resignFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func keyboradWillChange(notification: Notification){
        
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name==Notification.Name.UIKeyboardWillShow || notification.name==Notification.Name.UIKeyboardWillChangeFrame {
            view.frame.origin.y = -keyboardRect.height+250
            //Edit textFieldView style
        } else {
            view.frame.origin.y = +63
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
                self.userimageImageView.image = UIImage(data: data)
            }
        }
    }
    
    //UITableViewMethods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        cell.comment = self.post.comments[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == commentsshowed.count - 1 {
            if commentsshowed.count < totalEnteries {
                var index = commentsshowed.count
                limit = index + 1
                while index < limit {
                    commentsshowed.append(post.comments[index])
                    index = index + 1
                }
                self.perform(#selector(loadTable), with: nil, afterDelay: 2.0)
            }
        }
    }
    
    @objc func loadTable() {
        self.CommentsTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Image Methods
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}
