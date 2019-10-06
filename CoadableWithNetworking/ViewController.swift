//
//  ViewController.swift
//  CoadableWithNetworking
//
//  Created by ganesh padole on 13/07/1941 Saka.
//  Copyright © 1941 ganesh padole. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UITableViewController,UISearchResultsUpdating {
   

    var friends = [Friend]()
    var filteredFriends = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding searchbar on top
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Find a friend"
        search.searchResultsUpdater = self
        navigationItem.searchController = search
        
        SVProgressHUD.show()
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let url = "https://www.hackingwithswift.com/samples/friendface.json"
        jsonDecoder.decode([Friend].self, fromURL: url) { myFriendList in
            self.friends = myFriendList
            self.filteredFriends = myFriendList
            
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }
   
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = filteredFriends[indexPath.row]
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = friend.friendList
        
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
       
        filteredFriends = friends.matching(searchController.searchBar.text)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
     
    }
    
}

