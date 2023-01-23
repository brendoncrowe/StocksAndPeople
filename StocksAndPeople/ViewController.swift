//
//  ViewController.swift
//  StocksAndPeople
//
//  Created by Brendon Crowe on 1/23/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var users = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchQuery = "" {
        didSet {
            users = UserResults.fetchUsers().filter {
                let fullName = "\($0.name.first) \($0.name.last)"
                return fullName.uppercased().contains(searchQuery.uppercased())
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configVC()
        
    }
    
    func configVC() {
        tableView.dataSource = self
        searchBar.delegate = self
        loadData()
    }
    
    func loadData() {
        users = UserResults.fetchUsers()
    }
}

extension ViewController: UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let user = users[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = "\(user.name.first.capitalized) \(user.name.last.capitalized)"
        content.secondaryText = user.location.city.capitalized
        cell.contentConfiguration = content
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        searchQuery = searchText
    }
}

