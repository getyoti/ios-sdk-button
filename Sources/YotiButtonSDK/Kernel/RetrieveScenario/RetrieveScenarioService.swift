//
// Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation

final class RetrieveScenarioService: NSObject, URLSessionDelegate {

    private lazy var urlSession = URLSession(configuration: .default,
                                             delegate: self,
                                             delegateQueue: nil)

    func retrieve(scenario: Scenario, completion: @escaping (_ qrCodeURL: URL?, _ error: Error?) -> Void) {

        var urlComponents = URLComponents()
        urlComponents.scheme = EnvironmentConfiguration.URL.scheme
        urlComponents.host = EnvironmentConfiguration.URL.host
        urlComponents.port = EnvironmentConfiguration.URL.port
        urlComponents.path = String(format: EnvironmentConfiguration.URL.endpoint, scenario.clientSDKID, scenario.scenarioID)
        urlComponents.queryItems = [URLQueryItem(name: EnvironmentConfiguration.Transport.key, value: EnvironmentConfiguration.Transport.uri)]

        guard let url = urlComponents.url else {
            completion(nil, ShareRequestError.scenarioRetrievalError("Invalid Request Information. Malformed elements ClientSDKID or ScenarioID"))
            return
        }

        urlSession.dataTask(with: url) { (data, response, error) in

            guard let httpResponse = response as? HTTPURLResponse, error == nil else {
                completion(nil, error)
                return
            }

            let statusCode = httpResponse.statusCode

            guard 200...299 ~= statusCode else {
                completion(nil, ShareRequestError.httpRequestError(statusCode))
                return
            }

            guard let data = data else {
                completion(nil, ShareRequestError.scenarioRetrievalError("Empty response from url: \(url)"))
                return
            }

            guard let qrCodeURL = URL(dataRepresentation: data, relativeTo: nil) else {
                completion(nil, ShareRequestError.generic("Malformed QRCodeURL. Base64 Representation of data received: \(data.base64EncodedString())"))
                return
            }

            completion(qrCodeURL, nil)
        }.resume()
    }
}
