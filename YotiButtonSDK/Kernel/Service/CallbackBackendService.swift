//
//  CallbackBackendService.swift
//  YotiButtonSDK
//
//  Created by Casper Lee on 22/07/2017.
//  Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation

class CallbackBackendService: HTTPService, URLSessionDelegate {
    
    var scenario: Scenario?
    lazy var urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
    func callbackBackend(scenario: Scenario, token: String) {
        
        self.scenario = scenario
        let completion = scenario.backendCompletion
        
        guard let callbackBackendURL = scenario.callbackBackendURL else {
            completion(nil, GenericError.nilValue("callbackBackendURL"))
            return
        }
        
        var urlComponments = URLComponents(url: callbackBackendURL, resolvingAgainstBaseURL: true)
        urlComponments?.queryItems = [URLQueryItem(name: "token", value: token)]
        
        guard let url = urlComponments?.url else {
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
            
            completion(data, nil)
            
            }.resume()
    }
}

