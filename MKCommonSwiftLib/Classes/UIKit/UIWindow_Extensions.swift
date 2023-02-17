//
//  UIWindow_Extensions.swift
//  MKCommonSwiftLib
//
//  Created by MorganWang on 06/09/2022.
//

import Foundation
import UIKit

public
extension UIApplication {
    var currentWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            if let window = connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .compactMap({ $0 as? UIWindowScene })
                .first?.windows
                .first(where: { $0.isKeyWindow }) {
                return window
            } else if let window = UIApplication.shared.delegate?.window {
                return window
            } else {
                return nil
            }
        } else {
            if let window = UIApplication.shared.delegate?.window {
                return window
            } else {
                return nil
            }
        }
    }
}
