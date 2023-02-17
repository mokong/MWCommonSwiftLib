//
//  URL_Extensions.swift
//  MKCommonSwiftLib
//
//  Created by MorganWang on 06/09/2022.
//

import Foundation

public extension URL {
    var urlParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
        let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { result, item in
            result[item.name] = item.value
        }
    }
}
