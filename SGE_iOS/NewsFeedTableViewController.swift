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
    
    var posts: [Post] = Array()
    var postsshowed: [Post] = Array()
    var limit = 5
    var totalEnteries: Int!
    var searchBar = UISearchBar()
    var searchButtonAux = UIBarButtonItem()
    var refresher: UIRefreshControl!
    var indexaux: IndexPath!
    var group: String!

    @IBOutlet weak var SearchButton: UIBarButtonItem!
    
    @IBAction func ClickSearchButton(_ sender: Any) {
        searchBarShow()
    }
    
    @IBAction func AddPostButton(_ sender: UIBarButtonItem) {
        let createPost = self.storyboard?.instantiateViewController(withIdentifier: "createPostView")
        self.navigationController?.pushViewController(createPost!, animated: true)
    }
    
    struct Post: Decodable {
        var id_post: String = ""
        var createdBy: User? = nil
        var date: String = ""
        var group: String = ""
        var caption: String = ""
        var image: String? = nil
        var comments = [Comment]()
    }
    
    struct Comment: Decodable {
        var comment: String = ""
        var createdBy: User? = nil
    }
    
    struct User: Decodable {
        var username: String = ""
        var profileImage: String = ""
        var id_user: String = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if(!isUserLoggedIn) {
            self.performSegue(withIdentifier: "loginViewSegue", sender: self)
        }
        searchBar.delegate = self
        searchButtonAux = SearchButton
        SearchButton = navigationItem.rightBarButtonItem
        navigationItem.title = "Noticias"
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(NewsfeedTableViewController.populateTableView), for: UIControlEvents.valueChanged)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.addSubview(refresher)
        self.populateTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if(!isUserLoggedIn) {
            self.performSegue(withIdentifier: "loginViewSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPostSegue" {
            let cell = tableView.cellForRow(at: indexaux) as! PostCell
            let spv = segue.destination as? ShowPostViewController
            spv?.post = cell.post
        }
    }
    
    //UISerachBarViewMethods
    func searchBarShow() {
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        searchBar.barStyle = .default
        searchBar.tintColor = UIColor(hexString: "#dc9c03")
        searchBar.searchBarStyle = UISearchBarStyle.minimal
        searchBar.alpha = 0
        searchBar.showsCancelButton = true
        navigationItem.title = nil
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
        navigationItem.setLeftBarButton(searchButtonAux, animated: true)
        navigationItem.title = "Noticias"
        UIView.animate(withDuration: 0.3, animations:{self.navigationItem.titleView = nil}, completion: {finished in})
    }
    
    //UITableViewMethods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        indexaux = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowPostSegue", sender: cell)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsshowed.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.post = self.postsshowed[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
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
    
    @objc func populateTableView() {
        // Obtain JSON with all the posts
        let path = Bundle.main.path(forResource: "allPosts", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do{
            let data = try Data(contentsOf: url)
            posts = try JSONDecoder().decode([Post].self, from: data)
        }
        catch {
        }
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
    
    @objc func loadTable() {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
