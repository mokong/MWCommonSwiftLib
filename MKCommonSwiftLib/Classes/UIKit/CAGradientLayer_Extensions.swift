//
//  CAGradientLayer_Extensions.swift
//  MKCommonSwiftLib
//
//  Created by MorganWang on 06/09/2022.
//

import Foundation
import UIKit

/// 渐变色的方向
///
/// - LeftToRight: 从左到右
/// - TopToBottom: 从上到下
/// - RightToLeft: 从右到左
/// - BottomToTop: 从下到上
public enum GradientDirection {
    case LeftToRight
    case TopToBottom
    case RightToLeft
    case BottomToTop
    case unknown
}

public extension CAGradientLayer {
    /// 渐变背景
    ///
    /// - Parameters:
    ///   - viewBounds: 渐变背景范围
    ///   - fromColor: 渐变开始颜色
    ///   - toColor: 渐变结束颜色
    ///   - direction: 渐变方向
    static func gradualChangingColor(_ viewBounds: CGRect, fromColor: UIColor, toColor: UIColor, direction: GradientDirection) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = viewBounds

        //  创建渐变色数组，需要转换为CGColor颜色
        gradientLayer.colors = [fromColor.cgColor, toColor.cgColor]

        //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
        var startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0)
        var endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0)
        switch direction {
        case .LeftToRight:
            startPoint = CGPoint(x: 0.0, y: 0.5)
            endPoint = CGPoint(x: 1.0, y: 0.5)
        case .RightToLeft:
            startPoint = CGPoint(x: 1.0, y: 0.5)
            endPoint = CGPoint(x: 0.0, y: 0.5)
        case .TopToBottom:
            startPoint = CGPoint(x: 0.5, y: 0.0)
            endPoint = CGPoint(x: 0.5, y: 1.0)
        case .BottomToTop:
            startPoint = CGPoint(x: 0.5, y: 1.0)
            endPoint = CGPoint(x: 0.5, y: 0.0)
        default:
            startPoint = CGPoint(x: 0.0, y: 0.5)
            endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint

        //  设置颜色变化点，取值范围 0.0~1.0
        let beginNum: NSNumber = 0.0
        let endNum: NSNumber = 1.0
        gradientLayer.locations = [beginNum, endNum]
        return gradientLayer
    }
}
