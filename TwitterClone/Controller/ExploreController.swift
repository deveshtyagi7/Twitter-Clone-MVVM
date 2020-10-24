//
//  ExploreController.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 07/09/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit
private let reuseIdentifier = "UserCell"
class ExploreController : UITableViewController{
    //MARK: - Properties
    private var users = [User](){
        didSet{
            tableView.reloadData()
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
        
    }
    //MARK: - API
    
    func fetchUsers(){
        UserService.shared.fetchUsers { (users) in
            self.users = users
        }
    }
    
    //MARK: - Helpers
    
    func configureUI()  {
        view.backgroundColor = .white
        navigationItem.title = "Explore"
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
    
    }
}
extension ExploreController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        return cell
    }
    
    
}
