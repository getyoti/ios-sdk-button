//
//  Profile.swift
//  sdk-ios-swift
//
//  Created by Simon Hamadene on 15/10/2018.
//  Copyright © 2018 Luke Ashley-Fenn. All rights reserved.
//

import Foundation

struct ProfileDictionary: Decodable {
    let attributes: [Attribute]
}

struct Attribute {
    let name: String
    let value: String

    init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}

extension Attribute: Decodable {
    enum ProfileKeys: String, CodingKey {
        case name
        case value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProfileKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        let value = try container.decode(String.self, forKey: .value)
        self.init(name: name, value: value)
    }
}
