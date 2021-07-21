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
        UIColor(named: name, in: Resource.module, compatibleWith: .none)!
    }
}

private extension Resource {
    static func resourceBundle() -> Bundle? {
        guard let resourceBundleURL = Resource.module.url(
            forResource: "YotiButtonResourcesSDK",
                withExtension: "bundle") else { return nil }

        guard let resourceBundle = Bundle(url: resourceBundleURL) else { return nil }

        return resourceBundle
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
