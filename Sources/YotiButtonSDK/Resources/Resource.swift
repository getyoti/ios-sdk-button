//
// Copyright © 2020 Yoti Limited. All rights reserved.
//

import Foundation
import UIKit

final class Resource {
    static func loadImage(named name: String) -> UIImage {
        if let image = UIImage(named: name, in: Resource.module, compatibleWith: nil) {
            return image
        } else if let resourceBundle = resourceBundle(),
                  let image = UIImage(named: name, in: resourceBundle, compatibleWith: nil) {
            return image
        } else {
            return UIImage()
        }
    }

    static func color(named name: String) -> UIColor {
        if let color = UIColor(named: name, in: Resource.module, compatibleWith: .none) {
            return color
        } else if let resourceBundle = resourceBundle(),
                  let color = UIColor(named: name, in: resourceBundle, compatibleWith: nil) {
            return color
        } else {
            return .systemBlue
        }
    }

    static func fontData(named name: String, ofType extension: String?) -> Data? {
        if let path = Resource.module.url(forResource: name, withExtension: `extension`),
           let data = try? Data(contentsOf: path) {
            return data
        } else if let path = resourceBundle()?.url(forResource: name, withExtension: `extension`),
                  let data = try? Data(contentsOf: path) {
            return data
        } else {
            return nil
        }
    }
}

private extension Resource {
    static func resourceBundle() -> Bundle? {
        guard let resourceBundleURL = Bundle(for: Resource.self).url(forResource: "YotiButtonResourcesSDK",
                                                                     withExtension: "bundle") else { return nil }
        return Bundle(url: resourceBundleURL)
    }
}

extension Resource {
    /// Returns the resource bundle associated with the current Swift module.
    static var module: Bundle = {
        let bundleName = "YotiButtonSDK_YotiButtonSDK"

        let candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,

            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: Resource.self).resourceURL,

            // For command-line tools.
            Bundle.main.bundleURL,
        ]

        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }

        return Bundle(for: Resource.self)
    }()
}
