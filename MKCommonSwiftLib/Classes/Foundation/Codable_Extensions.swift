//
//  Codable_Extensions.swift
//  MorganWang
//
//  Created by MorganWang on 16/06/2022.
//

import Foundation

public
extension Encodable {
    var dict : [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return nil }
        return json
    }
}
