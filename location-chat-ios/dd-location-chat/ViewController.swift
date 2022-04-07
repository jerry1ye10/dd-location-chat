//
//  ViewController.swift
//  dd-location-chat
//
//  Created by Jerry Ye on 4/6/22.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var friendsTable: UITableView!

    var friends = ["Jerry", "Nancy", "Sebastian"]

    override func viewDidLoad() {
        //Load location and friend data here
        super.viewDidLoad()
        friendsTable.delegate = self
        friendsTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friend", for: indexPath)
        if let label = cell.viewWithTag(2) as? UILabel{
            print(friends[indexPath.row])
            label.text = friends[indexPath.row]
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    
}

