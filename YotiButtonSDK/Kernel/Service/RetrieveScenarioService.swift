//
//  RetrieveScenarioService.swift
//  YotiButtonSDK
//
//  Created by Casper Lee on 21/07/2017.
//  Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation

class RetrieveScenarioService: HTTPService, URLSessionDelegate {

    lazy var urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)

    func retrieve(scenario: Scenario, completion: @escaping (_ qrCodeURL: URL?, _ error: Error?) -> Void) {

        var urlComponents = URLComponents()
        urlComponents.scheme = EnvironmentConfiguation.URL.scheme
        urlComponents.host = EnvironmentConfiguation.URL.host
        urlComponents.port = EnvironmentConfiguation.URL.port
        urlComponents.path = String(format: EnvironmentConfiguation.URL.endpoint, scenario.clientSDKID, scenario.scenarioID)
        urlComponents.queryItems = [URLQueryItem(name: EnvironmentConfiguation.Transport.key, value: EnvironmentConfiguation.Transport.uri)]

        guard let url = urlComponents.url else {
            completion(nil, GenericError.malformedValue("url"))
            return
        }

        urlSession.dataTask(with: url) { (data, response, error) in

            guard let httpResponse = response as? HTTPURLResponse, error == nil else {
                completion(nil, error)
                return
            }

            let statusCode = httpResponse.statusCode

            guard 200...299 ~= statusCode else {
                completion(nil, NetworkError.httpError(httpResponse.statusCode))
                return
            }

            guard let data = data else {
                completion(nil, GenericError.nilValue("data"))
                return
            }

            guard let qrCodeURL = URL(dataRepresentation: data, relativeTo: nil) else {
                completion(nil, GenericError.malformedValue("qrCodeURL"))
                return
            }

            completion(qrCodeURL, nil)
        }.resume()
    }
}
