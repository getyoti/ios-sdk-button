//
// Copyright © 2021 Yoti Limited. All rights reserved.
//

import Foundation

public enum ShareRequestError: Error {
    case httpRequestError(Int)
    case scenarioRetrievalError(String)
    case startScenarioError(String)
    case generic(String)
}

extension ShareRequestError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .httpRequestError(let code):
                return "[Network Request Error] HTTP StatusCode: \(code)"
            case .scenarioRetrievalError(let reason):
                return "[Scenario Retrieval Error] Reason: \(reason)"
            case .startScenarioError(let reason):
                return "[Scenario Start Error] Reason: \(reason)"
            case .generic(let reason):
                return "[Generic Error] Reason: \(reason)"
        }
    }
}
