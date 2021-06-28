//
// Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static func register(font: String, type: String?) {
        let bundle = Bundle(for: YotiSDK.self)
        guard let path = bundle.url(forResource: font, withExtension: type),
              let data = try? Data(contentsOf: path),
              let provider = CGDataProvider(data: data as CFData)
        else {
            return
        }

        var error: Unmanaged<CFError>?
        guard let font = CGFont(provider) else { return }

        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}
