//
//  NotificationController.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 07/09/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit
private let reuseIdentifier = "NotificationCell"
class NotificationsController : UITableViewController{
    //MARK: - Properties
    private var notifications = [Notification](){
        didSet{
            tableView.reloadData()
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchNotifications()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .default
        
    }
    //MARK: - APIS
    func fetchNotifications(){
        NotificationService.shared.fetchNotification { notifications in
            self.notifications = notifications
        }
    }
    //MARK: - Helpers
    func configureUI()  {
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
        
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        
        tableView.separatorStyle = .none
        
    }
    
}
//MARK: - Table Data Souxrce

extension NotificationsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCell
        cell.notification = notifications[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notification = notifications[indexPath.row]
        guard let tweetId = notification.tweetID else { return }
        TweetServices.shared.fetchTweet(withTweetID: tweetId) { (tweet) in
            let controller = TweetController(tweet: tweet)
                self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}
//MARK: - NotificationCellDelegate
extension NotificationsController : NotificationCellDelegate{
    func didTapProfileImage(_ cell: NotificationCell) {
        guard let user = cell.notification?.user else {return}
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
        
        }
    
    
}
