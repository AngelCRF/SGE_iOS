//
//  GroupFeedViewController.swift
//  SGE_iOS
//
//  Created by Kevin Angel on 29/07/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import Foundation
import UIKit

class GroupFeedViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [NewsfeedTableViewController.Post] = Array()
    var postsshowed: [NewsfeedTableViewController.Post] = Array()
    var members: [NewsfeedTableViewController.User] = Array()
    var limit = 5
    var totalEnteries: Int!
    var refresher: UIRefreshControl!
    var groupobj: group!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor(hexString: "#dc9c03")
        navigationItem.title = groupobj.getName()
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(GroupFeedViewController.populateViews), for: UIControlEvents.valueChanged)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.addSubview(refresher)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.populateViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPostSegueG" {
            let cell = sender as! GroupPostCell
            let spv = segue.destination as? ShowPostViewController
            spv?.post = cell.post
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func populateViews() {
        // Obtain JSON with members of grup
        let pathmembers = Bundle.main.path(forResource: "members", ofType: "json")
        let urlmembers = URL(fileURLWithPath: pathmembers!)
        do{
            let datamem = try Data(contentsOf: urlmembers)
            members = try JSONDecoder().decode([NewsfeedTableViewController.User].self, from: datamem)
        }
        catch { }
        // Obtain JSON with all the posts
        let path = Bundle.main.path(forResource: "allPosts", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do{
            let data = try Data(contentsOf: url)
            posts = try JSONDecoder().decode([NewsfeedTableViewController.Post].self, from: data)
        }
        catch { }
        totalEnteries = posts.count
        postsshowed.removeAll()
        var index = 0
        while index < limit {
            postsshowed.append(posts[index])
            index = index + 1
        }
        self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
        refresher.endRefreshing()
    }
    
    //UITableViewMethods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsshowed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupPostCell", for: indexPath) as! GroupPostCell
        cell.post = self.postsshowed[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == postsshowed.count - 1 {
            if postsshowed.count < totalEnteries {
                var index = postsshowed.count
                limit = index + 5
                while index < limit {
                    postsshowed.append(posts[index])
                    index = index + 1
                }
                self.perform(#selector(loadTable), with: nil, afterDelay: 2.0)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowPostSegueG", sender: cell)
    }
    
    @objc func loadTable() {
        self.tableView.reloadData()
    }
    
    //UICollectionMethods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memberCell", for: indexPath) as! MembersCollectionViewCell
        let data = try? Data(contentsOf: URL(string:members[indexPath.item].profileImage)!)
        if let imageData = data {
            let image = UIImage(data: imageData)
            cell.memberImageView.image = image
        } else {
            cell.memberImageView.image = #imageLiteral(resourceName: "pony")
        }
        cell.memberImageView?.layer.masksToBounds = true
        cell.memberImageView?.layer.cornerRadius = 35
        return cell
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
}
