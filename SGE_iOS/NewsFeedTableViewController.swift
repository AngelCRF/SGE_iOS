//
//  NewsFeedTableViewController.swift
//  SGE_iOS
//
//  Created by Kevin Angel on 11/02/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import Foundation
import UIKit


class NewsfeedTableViewController : UITableViewController
{
    var searchController: UISearchController!
    var posts: [Post]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()
        self.fetchPosts()
        tableView.separatorStyle = .none
        // dynamic table view cell height
        //tableView.estimatedRowHeight = 100.0
        //tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 488.0
        tableView.estimatedRowHeight = tableView.rowHeight
    }
    
    func fetchPosts()
    {
        self.posts = Post.fetchPosts()
        tableView.reloadData()
    }
    
    func setupSearchController()
    {
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.barStyle = .black
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
    }
}

extension NewsfeedTableViewController
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.post = self.posts?[indexPath.row]
        return cell
    }
}


