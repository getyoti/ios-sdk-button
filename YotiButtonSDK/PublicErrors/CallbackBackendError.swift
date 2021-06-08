//
// Copyright © 2021 Yoti Limited. All rights reserved.
//

import Foundation

/// Describes potential errors during the process of communicating and executing the Backend callback.
public enum CallbackBackendError: Error {
    case httpRequestError(Int)
    case invalidCallbackBackendURL(String)
}

extension CallbackBackendError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .httpRequestError(let code):
                return "[Network Request Error] HTTP StatusCode: \(code)"
            case .invalidCallbackBackendURL(let reason):
                return "Invalid CallbackBackednURL. Reason: \(reason)"
        }
    }
}
