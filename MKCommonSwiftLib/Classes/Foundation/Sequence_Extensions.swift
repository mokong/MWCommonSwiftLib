//
//  Sequence_Extensions.swift
// MorganWang
//
//  Created by MorganWang on 21/09/2022.
//

import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
