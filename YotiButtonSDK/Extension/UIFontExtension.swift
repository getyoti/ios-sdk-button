//
// Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static func bodyFont(ofSize fontSize: CGFloat = 16) -> UIFont {
        UIFont.register(font: "Roboto-Medium", type: "ttf")
        return UIFont(name: "Roboto-Medium", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }

    static func register(font: String, type: String?) {
        let bundle = Bundle(for: YotiSDK.self)
        guard let path = bundle.url(forResource: font, withExtension: type),
              let data = try? Data(contentsOf: path),
              let provider = CGDataProvider(data: data as CFData)
        else {
            return
        }

        var error: Unmanaged<CFError>?
        guard let font = CGFont(provider) else {
            return
        }

        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}
