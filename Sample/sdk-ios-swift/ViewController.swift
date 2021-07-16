//
//  Copyright © 2018 Yoti Ltd. All rights reserved.
//

import UIKit
import YotiButtonSDK

class ViewController: UIViewController {

    var responseObject: ProfileDictionary?
    @IBOutlet weak var rememberMeButton: YotiButton!
    @IBOutlet weak var selfieAuthButton: YotiButton!
    @IBOutlet weak var unfulfilledButton: YotiButton!

    func yotiButtonDidTouchUpInside(_ sender: YotiButton) {
        guard let useCaseID = sender.useCaseID else {
             return
        }
        do {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            try YotiSDK.startScenario(for: useCaseID, theme: sender.theme, with: self)
        } catch let error {
            print("\(error.localizedDescription)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rememberMeButton.theme = .yoti
        unfulfilledButton.theme = .easyID

        let action: YotiButton.TouchedUpInside = { [weak self] button in
            self?.yotiButtonDidTouchUpInside(button)
        }

        rememberMeButton.action = action
        selfieAuthButton.action = action
        unfulfilledButton.action = action
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rememberMeButton.setTitle("RememberMe Scenario", for: .normal)
        selfieAuthButton.setTitle("SelfieAuth Scenario", for: .normal)
    }

    func moveToProfile() {
        performSegue(withIdentifier: "moveToProfile", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "moveToProfile":
            guard let viewController = segue.destination as? ProfileViewController else { break }
            guard let responseObject = responseObject, !responseObject.attributes.isEmpty else { break }
            responseObject.attributes.forEach {

                if $0.name == "selfie" {
                    let selfieValue = $0.value
                    if let imageData = Data(base64Encoded: selfieValue) {
                        let photo = UIImage(data: imageData)
                        viewController.selfie = photo
                    }
                }
                if $0.name == "phone_number" {
                    let phoneNumberValue = $0.value
                    viewController.phone = phoneNumberValue
                }
                if $0.name == "given_names"{
                    let givenNamesValue = $0.value
                    viewController.givenNames = givenNamesValue
                }
                if $0.name == "postal_address"{
                    let postalAddressValue = $0.value
                    viewController.postalAddress = postalAddressValue
                }
                if $0.name == "gender"{
                    let genderValue = $0.value
                    viewController.gender = genderValue
                }
                if $0.name == "email_address"{
                    let emailAddressValue = $0.value
                    viewController.emailAddress = emailAddressValue
                }
                if $0.name == "family_name"{
                    let familyNameValue = $0.value
                    viewController.familyName = familyNameValue
                }
                if $0.name == "date_of_birth"{
                    let dateOfBirthValue = $0.value
                    viewController.dateOfBirth = dateOfBirthValue
                }
            }
        default:
            break
        }
    }
}

extension ViewController: SDKDelegate {
    func yotiSDKDidFail(for useCaseID: String, appStoreURL: URL?, with error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        print(error)
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
        do {
            let decodedJson = try JSONDecoder().decode(ProfileDictionary.self, from: data)
            responseObject = decodedJson
            moveToProfile()
        } catch let error {
            print (error)
        }
    }
}
