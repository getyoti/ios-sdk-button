//
//  ViewController.swift
//  sdk-ios-swift
//
//  Created by Luke Ashley-Fenn on 29/01/2018.
//  Copyright © 2018 Luke Ashley-Fenn. All rights reserved.
//

import UIKit
import YotiButtonSDK

class ViewController: UIViewController {
    
    var responseObject: [String: Any]?
    @IBOutlet weak var rememberMeButton: YotiButton!
    @IBOutlet weak var selfieAuthButton: YotiButton!
    
    
    @IBAction func yotiButtonDidTouchUpInside(_ sender: YotiButton) {
        guard let useCaseID = sender.useCaseID else{
             return
        }
        do {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            try YotiSDK.startScenario(for: useCaseID, with: self)
        } catch {
            // FIXME
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rememberMeButton.setTitle("RememberMe Scenario", for: .normal)
        selfieAuthButton.setTitle("SelfieAuth Scenario", for: .normal)
    }

    func moveToProfile() {
        performSegue(withIdentifier: "moveToProfile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case "moveToProfile":
            guard let viewController = segue.destination as? ProfileViewController else {
                break
            }
            
            guard let responseObject = responseObject,
                let userInfo = responseObject["userInfo"] as? [String: Any] else {
                    break
            }
            
            if let selfie = userInfo["selfie"] as? String
            {
                let base64Image = selfie.replacingOccurrences(of: "data:image/jpeg;base64,", with: "")
                if let imageData = Data(base64Encoded: base64Image) {

                    let photo = UIImage(data: imageData)
                    viewController.selfie = photo
                }
            }
            
            if let phone = userInfo["phoneNumber"] as? String {
                viewController.phone = phone
            }

            if let givenNames = userInfo["givenNames"] as? String {
                viewController.givenNames = givenNames
            }
            
            if let postalAddress = userInfo["postalAddress"] as? String {
                viewController.postalAddress = postalAddress
            }
            
            if let gender = userInfo["gender"] as? String {
                viewController.gender = gender
            }

            if let emailAddress = userInfo["emailAddress"] as? String {
                viewController.emailAddress = emailAddress
            }
            
            if let familyName = userInfo["familyName"] as? String {
                viewController.familyName = familyName
            }

            if let dateOfBirth = userInfo["dateOfBirth"] as? String {
                viewController.dateOfBirth = dateOfBirth
            }
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: YotiSDKDelegate {
    func yotiSDKDidFail(for useCaseID: String, with error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    func yotiSDKDidSucceed(for useCaseID: String, baseURL: URL?, token: String?, url: URL?) {
        let scenario = YotiSDK.scenario(for: useCaseID)
        YotiSDK.callbackBackend(scenario: scenario!, token: token!, with: self)
    }

    func yotiSDKDidOpenYotiApp() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

extension ViewController: BackendDelegate {
    func backendDidFinish(with data: Data?, error: Error?) {
        guard let data = data else {
            return
        }
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        
        //We would have to parse Jason at this point in order to create the `responseObject` Dictionary which will be used in override func prepare(for segue: UIStoryboardSegue, sender: Any?) before moving to profile screen. For now we only printing  the JSON
        print (json ?? "")
    }
}


