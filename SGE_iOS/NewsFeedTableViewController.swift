//
//  NewsFeedTableViewController.swift
//  SGE_iOS
//
//  Created by Kevin Angel on 11/02/18.
//  Copyright © 2018 KEAM. All rights reserved.
//

import Foundation
import UIKit

class NewsfeedTableViewController : UITableViewController, UISearchBarDelegate {
    var posts: [Post]?
    var searchBar = UISearchBar()
    var SearchButtonAux = UIBarButtonItem()
    
    @IBOutlet weak var SearchButton: UIBarButtonItem!
    
    @IBAction func ClickSearchButton(_ sender: Any) {
        searchBarShow()
    }
    
    @IBAction func AddPostButton(_ sender: UIBarButtonItem) {
        let createPost = self.storyboard?.instantiateViewController(withIdentifier: "createPostView")
        self.navigationController?.pushViewController(createPost!, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if(!isUserLoggedIn) {
            self.performSegue(withIdentifier: "loginViewSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if(!isUserLoggedIn) {
            self.performSegue(withIdentifier: "loginViewSegue", sender: self)
        }
        self.fetchPosts()
        SearchButtonAux = SearchButton
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        searchBar.delegate = self
        SearchButton = navigationItem.rightBarButtonItem
    }
    
    func fetchPosts() {
        self.posts = Post.fetchPosts()
        tableView.reloadData()
    }
    
    func searchBarShow() {
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        searchBar.barStyle = .default
        searchBar.tintColor = UIColor(hexString: "#dc9c03")
        searchBar.searchBarStyle = UISearchBarStyle.minimal
        searchBar.alpha = 0
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
        navigationItem.setLeftBarButton(nil, animated: true)
        UIView.animate(withDuration: 0.5, animations: {self.searchBar.alpha = 1}, completion: {finished in self.searchBar.becomeFirstResponder()})
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Do the search stuff
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        navigationItem.setLeftBarButton(SearchButtonAux, animated: true)
        UIView.animate(withDuration: 0.3, animations:{self.navigationItem.titleView = nil}, completion: {finished in})
    }
}

extension NewsfeedTableViewController {
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
