//
//  UIViewController_Extensions.swift
//  meijuplay
//
//  Created by Horizon on 22/12/2021.
//

import Foundation
import UIKit

public extension UIViewController {
    var topBarHeight: CGFloat {
        var top = self.navigationController?.navigationBar.frame.height ?? 0.0
        top += UIDevice.statusBarH()
        return top
    }
    
    static func navBarColor() -> UIColor {
        return UIColor.MWCustomColor.themeColor
    }
}

public
struct AlertAction {
    let buttonTitle: String
    let style: UIAlertAction.Style
    let handler: (() -> Void)?
}

public
struct ButtonAlert {
    let title: String?
    let message: String?
    let action: AlertAction
    let anotherAction: AlertAction?
}

public
protocol ButtonDialogPresenter {
    func presentSingleButtonDialog(alert: ButtonAlert)
}

public
extension ButtonDialogPresenter where Self: UIViewController {
    func presentSingleButtonDialog(alert: ButtonAlert) {
        let alertController = UIAlertController(title: alert.title,
                                                message: alert.message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: alert.action.buttonTitle,
                                                style: alert.action.style,
                                                handler: { _ in
            alert.action.handler?()
        }))
        
        if let anotherAction = alert.anotherAction {
            alertController.addAction(UIAlertAction(title: anotherAction.buttonTitle,
                                                    style: anotherAction.style,
                                                    handler: { _ in
                anotherAction.handler?()
            }))
        }
        
        self.present(alertController, animated: true)
    }
}

public
extension UIViewController {
    // MARK: - 找到当前显示的viewcontroller
    class func current(base: UIViewController? = UIApplication.shared.currentWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return current(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return current(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return current(base: presented)
        }
        if let split = base as? UISplitViewController {
            return current(base: split.presentingViewController)
        }
        return base
    }
    static func hx_currentController() -> UIViewController {
        var currentViewController = self.hx_getCurrentRootCOntroller()
        let runLoopFind = true
        while runLoopFind == true {
            if currentViewController.presentedViewController != nil {
                currentViewController = currentViewController.presentedViewController!
            } else if currentViewController.isKind(of: UINavigationController.self) {
                let navi = currentViewController as? UINavigationController
                currentViewController = navi?.children.last! ?? UIViewController()
            } else if currentViewController.isKind(of: UITabBarController.self) {
                let tabbar = currentViewController as? UITabBarController
                currentViewController = tabbar?.selectedViewController! ?? UIViewController()
            } else {
                let childViewControllerCount = currentViewController.children.count
                if childViewControllerCount > 0 {
                    currentViewController = currentViewController.children.last!
                    return currentViewController
                } else {
                    return currentViewController
                }
            }
        }
        return currentViewController
    }
    static func hx_getCurrentRootCOntroller() -> UIViewController {
        var currentWindowVC : UIViewController
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != .normal {
            let windows = UIApplication.shared.windows
            for tempWindow in windows where tempWindow.windowLevel == .normal {
                window = tempWindow
            }
        }
        let frontView = (window?.subviews.first)! as UIView
        let nextResponder = frontView.next
        if (nextResponder?.isKind(of: UIViewController.self)) == true {
            currentWindowVC = nextResponder as? UIViewController ?? UIViewController()
        } else {
            currentWindowVC = (window?.rootViewController)!
        }
        return currentWindowVC
    }
}
