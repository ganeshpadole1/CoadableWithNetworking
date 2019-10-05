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
        
        DispatchQueue.global().async {
            
            do {
                let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")
                let data = try Data(contentsOf: url!)
                
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .iso8601
                let downloadedJSON = try jsonDecoder.decode([Friend].self, from: data)
                print(downloadedJSON)
                
                DispatchQueue.main.async {
                    self.friends = downloadedJSON
                    self.filteredFriends = downloadedJSON
                    self.tableView.reloadData()
                    SVProgressHUD.dismiss()
                }
            } catch {
                fatalError("Error occured")
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = filteredFriends[indexPath.row]
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = friend.friends.map {$0.name}.joined(separator: ",")
        
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 0 {
          filteredFriends = friends.filter {
                $0.name.contains(text) ||
                $0.company.contains(text) ||
                $0.address.contains(text)
            }
        } else {
            filteredFriends = friends
        }
        
        tableView.reloadData()
    }
    
}

