//
// Copyright © 2020 Yoti Limited. All rights reserved.
//

import Foundation
import UIKit

final class Resource {
    private static var bundle: Bundle { Bundle(for: Self.self) }

    static func loadImage(named name: String) -> UIImage {
        if let image = UIImage(named: name, in: bundle, compatibleWith: nil) {
            return image
        } else if let resourceBundle = resourceBundle(),
            let image = UIImage(named: name, in: resourceBundle, compatibleWith: nil) {
            return image
        } else {
            return UIImage()
        }
    }

    static func color(named name: String) -> UIColor {
        UIColor(named: name, in: bundle, compatibleWith: .none)!
    }
}

private extension Resource {
    static func resourceBundle() -> Bundle? {
        guard let resourceBundleURL = bundle.url(
            forResource: "YotiButtonResourcesSDK",
                withExtension: "bundle") else { return nil }

        guard let resourceBundle = Bundle(url: resourceBundleURL) else { return nil }

        return resourceBundle
    }
}
