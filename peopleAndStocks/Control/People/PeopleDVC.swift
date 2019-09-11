//
//  PeopleDVC.swift
//  peopleAndStocks
//
//  Created by Alyson Abril on 9/5/19.
//  Copyright © 2019 Alyson Abril. All rights reserved.
//

import UIKit

class PeopleDVC: UIViewController {

    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var person: People!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDVC()
    }
    
    private func updateDVC() {
        personImage.image = UIImage(named: "profileImage")
        nameLabel.text =  person.name.fullName
        emailLabel.text = person.email
        addressLabel.text = person.location.address
    }
}
