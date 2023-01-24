//
//  UserDetailViewController.swift
//  StocksAndPeople
//
//  Created by Brendon Crowe on 1/23/23.
//

import UIKit

class UserDetail: UIViewController {
    
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userCityLabel: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    func updateUI() {
        if let user = user {
            userNameLabel.text = "\(user.name.first.capitalized) \(user.name.last.capitalized)"
            userEmailLabel.text = user.email
            userCityLabel.text = user.location.city.capitalized
        }
        return
    }
}
