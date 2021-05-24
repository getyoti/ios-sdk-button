//
// Copyright © 2021 Yoti Limited. All rights reserved.
//

import Foundation

public enum CallbackBackendError: Error {
    case invalidCallbackBackendURL(String)
}

extension CallbackBackendError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .invalidCallbackBackendURL(let reason):
                return "Invalid CallbackBackednURL. Reason: \(reason)"
        }
    }
}
