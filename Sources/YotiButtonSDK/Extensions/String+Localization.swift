//
// Copyright © 2021 Yoti Ltd. All rights reserved.
//

import Foundation

extension String {
    func localization(stockValue: String) -> String {
        Bundle.main.localizedString(forKey: self, value: stockValue, table: "YotiButtonSDK")
    }
}
