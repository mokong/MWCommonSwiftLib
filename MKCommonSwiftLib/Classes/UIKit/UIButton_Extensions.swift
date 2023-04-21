//
//  UIButton_Extensions.swift
//  CommonSwiftExtension
//
//  Created by MorganWang on 17/05/2022.
//

import Foundation
import UIKit

public extension UIButton {
    func setInsets(
        forContentPadding contentPadding: UIEdgeInsets,
        imageTitlePadding: CGFloat
    ) {
        self.contentEdgeInsets = UIEdgeInsets(
            top: contentPadding.top,
            left: contentPadding.left,
            bottom: contentPadding.bottom,
            right: contentPadding.right + imageTitlePadding
        )
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: imageTitlePadding,
            bottom: 0,
            right: -imageTitlePadding
        )
    }
    
    enum ImageTitleLocation {
        case imageUpTitleDown
        case imageDownTitleUp
        case imageLeftTitleRight
        case imageRightTitleLeft
    }

    func centerContentRelativeLocation(_ relativeLocation:
                                       ImageTitleLocation,
                                   spacing: CGFloat = 0) {
    assert(contentVerticalAlignment == .center,
           "only works with contentVerticalAlignment = .center !!!")

    guard (title(for: .normal) != nil) || (attributedTitle(for: .normal) != nil) else {
        assert(false, "TITLE IS NIL! SET TITTLE FIRST!")
        return
    }

    guard let imageSize = self.currentImage?.size else {
        assert(false, "IMGAGE IS NIL! SET IMAGE FIRST!!!")
        return
    }
    guard let titleSize = titleLabel?
        .systemLayoutSizeFitting(UIView.layoutFittingCompressedSize) else {
            assert(false, "TITLELABEL IS NIL!")
            return
    }

    let horizontalResistent: CGFloat
    // extend contenArea in case of title is shrink
     
     let titleAndImageW: CGFloat = titleSize.width + imageSize.width
    if frame.width < titleAndImageW {
            horizontalResistent = titleAndImageW - frame.width
    //            print("horizontalResistent", horizontalResistent)
        } else {
            horizontalResistent = 0
        }

        var adjustImageEdgeInsets: UIEdgeInsets = .zero
        var adjustTitleEdgeInsets: UIEdgeInsets = .zero
        var adjustContentEdgeInsets: UIEdgeInsets = .zero

        let verticalImageAbsOffset = abs((titleSize.height + spacing) / 2.0)
        let verticalTitleAbsOffset = abs((imageSize.height + spacing) / 2.0)

        switch relativeLocation {
        case .imageUpTitleDown:

            adjustImageEdgeInsets.top = -verticalImageAbsOffset
            adjustImageEdgeInsets.bottom = verticalImageAbsOffset
            adjustImageEdgeInsets.left = titleSize.width / 2.0 + horizontalResistent / 2.0
            adjustImageEdgeInsets.right = -titleSize.width / 2.0 - horizontalResistent / 2.0

            adjustTitleEdgeInsets.top = verticalTitleAbsOffset
            adjustTitleEdgeInsets.bottom = -verticalTitleAbsOffset
            adjustTitleEdgeInsets.left = -imageSize.width / 2.0 + horizontalResistent / 2.0
            adjustTitleEdgeInsets.right = imageSize.width / 2.0 - horizontalResistent / 2.0

            adjustContentEdgeInsets.top = spacing
            adjustContentEdgeInsets.bottom = spacing
            adjustContentEdgeInsets.left = -horizontalResistent
            adjustContentEdgeInsets.right = -horizontalResistent
        case .imageDownTitleUp:
            adjustImageEdgeInsets.top = verticalImageAbsOffset
            adjustImageEdgeInsets.bottom = -verticalImageAbsOffset
            adjustImageEdgeInsets.left = titleSize.width / 2.0 + horizontalResistent / 2.0
            adjustImageEdgeInsets.right = -titleSize.width / 2.0 - horizontalResistent / 2.0

            adjustTitleEdgeInsets.top = -verticalTitleAbsOffset
            adjustTitleEdgeInsets.bottom = verticalTitleAbsOffset
            adjustTitleEdgeInsets.left = -imageSize.width / 2.0 + horizontalResistent / 2.0
            adjustTitleEdgeInsets.right = imageSize.width / 2.0 - horizontalResistent / 2.0

            adjustContentEdgeInsets.top = spacing
            adjustContentEdgeInsets.bottom = spacing
            adjustContentEdgeInsets.left = -horizontalResistent
            adjustContentEdgeInsets.right = -horizontalResistent
        case .imageLeftTitleRight:
            adjustImageEdgeInsets.left = -spacing / 2.0
            adjustImageEdgeInsets.right = spacing / 2.0

            adjustTitleEdgeInsets.left = spacing / 2.0
            adjustTitleEdgeInsets.right = -spacing / 2.0

            adjustContentEdgeInsets.left = spacing
            adjustContentEdgeInsets.right = spacing
        case .imageRightTitleLeft:
            adjustImageEdgeInsets.left = titleSize.width + spacing / 2.0
            adjustImageEdgeInsets.right = -titleSize.width - spacing / 2.0

            adjustTitleEdgeInsets.left = -imageSize.width - spacing / 2.0
            adjustTitleEdgeInsets.right = imageSize.width + spacing / 2.0

            adjustContentEdgeInsets.left = spacing
            adjustContentEdgeInsets.right = spacing
        }

        imageEdgeInsets = adjustImageEdgeInsets
        titleEdgeInsets = adjustTitleEdgeInsets
        contentEdgeInsets = adjustContentEdgeInsets

        setNeedsLayout()
    }
    
}
