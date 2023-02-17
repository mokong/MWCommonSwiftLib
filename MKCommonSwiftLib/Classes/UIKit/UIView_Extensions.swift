//
//  UIView_Extensions.swift
//  CommonSwiftExtension
//
//  Created by MorganWang on 17/05/2022.
//

import Foundation
import UIKit

public extension UIView {
    /// Remove all subviews
    func removeAllSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
    
    /// remove all subview with a specific type
    func removeAllSubviews<T: UIView>(type: T.Type) {
        subviews
            .filter({ $0.isMember(of: type) })
            .forEach({ $0.removeFromSuperview() })
    }

    func snapshotImage() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            rendererContext.cgContext.setFillColor(UIColor.cyan.cgColor)
            rendererContext.cgContext.setStrokeColor(UIColor.yellow.cgColor)
            layer.render(in: rendererContext.cgContext)
        }
    }

    func snapshotView() -> UIView? {
        if let snapshotImage = snapshotImage() {
            return UIImageView(image: snapshotImage)
        } else {
            return nil
        }
    }
    
    //设置部分圆角
    func setRoundCorners(corners:UIRectCorner, with radii:CGFloat) {
        let bezierpath:UIBezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let shape:CAShapeLayer = CAShapeLayer()
        shape.frame = bounds
        shape.path = bezierpath.cgPath
        shape.shouldRasterize = true
        shape.rasterizationScale = UIScreen.main.scale

        self.layer.mask = shape
    }

    /**
     *width 虚线宽度
     *length 虚线长度
     *space 虚线间隔
     *radius view圆角
     *color 虚线颜色
     */
    func setBorderDottedLine(width:CGFloat, length:CGFloat, space:CGFloat, radius:CGFloat, color:UIColor) {
        self.layer.cornerRadius = radius
        let borderLayer = CAShapeLayer()
        borderLayer.bounds = self.bounds
        borderLayer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        borderLayer.path = UIBezierPath(roundedRect: layer.bounds, cornerRadius: radius).cgPath
        borderLayer.lineWidth = width / UIScreen.main.scale
        
        //单个虚线点的长度
        borderLayer.lineDashPattern = [length, space] as [NSNumber]?
        borderLayer.lineDashPhase = 0.1
        
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = color.cgColor
        
        self.layer.addSublayer(borderLayer)
    }
    
    // 设置虚线
    func createDashedLine(from point1: CGPoint, to point2: CGPoint, color: UIColor = UIColor.custom.line, strokeLength: NSNumber = NSNumber(5), gapLength: NSNumber = NSNumber(3)) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = self.bounds.height
        shapeLayer.lineDashPattern = [strokeLength, gapLength]
        let path = CGMutablePath()
        path.addLines(between: [point1, point2])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }

}
