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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        do {
            
            guard let url = URL(string: "https://android-test-yoti.herokuapp.com/profile-json") else {
                return
            }
            let scenario = try ScenarioBuilder().setUseCaseID("yoti_btn_1")
                .setClientSDKID("d28feaf4-d62d-40e3-88ae-d619e9a5b906")
                .setScenarioID("60b8e997-4a5c-40b2-86e8-29c4521b7015")
                .setClientCompletion({ (baseURL, token, url, error) in
                    print("token: \(String(describing: token))")
                    print("url: \(String(describing: url))")
                    // If you decide to call the callback url via
                    // your own Service and handle the result, set  isProcessed at true.
                    // Otherwise, set isProcessed at false and the Yoti SDK
                    // will make the call.
                    return false
                })
                .setCallbackBackendURL(url)
                .setBackendCompletion({ (data, error) in
                    print("=== Backend Completion ===")
                    print("object: \(String(describing: data))")
                    print("error: \(String(describing: error))")
                    
                    self.responseObject = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String : Any]

                    
                    if error == nil {
                        DispatchQueue.main.async {
                            self.moveToProfile()
                        }
                    }
                    
                    
                })
                .create()
            YotiSDK.add(scenario: scenario)
        }
        catch {
            
        }
        NotificationCenter.default.addObserver(forName: YotiSDK.willMakeNetorkRequest, object: nil, queue: nil) { (notification) in
            print("+1")
        }
        NotificationCenter.default.addObserver(forName: YotiSDK.didFinishNetworkRequest, object: nil, queue: nil) { (notification) in
            print("-1")
        }


        // Do any additional setup after loading the view, typically from a nib.
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

