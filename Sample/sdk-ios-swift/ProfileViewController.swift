//
//  ProfileViewController.swift
//  YotiButtonSDK
//
//  Created by Casper Lee on 23/07/2017.
//  Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var givenNameView: UILabel!
    @IBOutlet weak var postalAddressView: UILabel!
    @IBOutlet weak var genderView: UILabel!
    @IBOutlet weak var emailAddressView: UILabel!
    @IBOutlet weak var familyNameView: UILabel!
    @IBOutlet weak var dateOfBirthView: UILabel!

    var phone: String?
    var selfie: UIImage?
    var givenNames: String?
    var postalAddress: String?
    var gender: String?
    var emailAddress: String?
    var familyName: String?
    var dateOfBirth: String?
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        photoView?.image = selfie
        phoneLabel.text = phone
        givenNameView.text = givenNames
        postalAddressView.text = postalAddress
        genderView.text = gender
        emailAddressView.text = emailAddress
        familyNameView.text = familyName
        dateOfBirthView.text = dateOfBirth
    }
    
    
    
}
