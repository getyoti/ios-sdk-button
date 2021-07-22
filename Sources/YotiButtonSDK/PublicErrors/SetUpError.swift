//
// Copyright © 2021 Yoti Limited. All rights reserved.
//

import Foundation

/// Describes potential errors during the setup process of the SDK
public enum SetupError: Error {
    case invalidBundleURLSchemes
    case invalidApplicationQueriesSchemes(URL?)
    case noIDAppInstalled(URL)
}

extension SetupError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .invalidBundleURLSchemes:
                return "CFBundleURLSchemes not defined properly."
            case .invalidApplicationQueriesSchemes(let url):
                if let url = url {
                    return "Cannot launch Yoti app with url: \(url.path). Check LSApplicationQueriesSchemes or install Yoti."
                } else {
                    return "Cannot launch Yoti app. Check LSApplicationQueriesSchemes"
                }
            case .noIDAppInstalled(let url):
                return "An ID app has not been installed, it can be downloaded here: \(url)"
        }
    }
}
