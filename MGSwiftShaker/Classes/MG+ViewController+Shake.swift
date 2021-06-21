//
//  MG+ViewController+Shake.swift
//  MGSwiftShaker
//
//  Created by hello on 2021/6/17.
//

import UIKit

extension UIViewController {
    open override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("Start Shake")
    }
    
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("End Shake")
        
        let shaker = MGShaker.shared
        guard shaker?.isSupport == true else {
            return
        }
        
        let vc = MGShakeViewController()
        let nav = UINavigationController(rootViewController: vc)
        UIViewController.topViewController()?.present(nav, animated: true, completion: nil)
    }
    
    open override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("Shake cancel")
    }
}

extension UIViewController {
    // Get top view controller
    class func topViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.first
        let rootVC = keyWindow?.rootViewController
        var resultVC = self.topViewController(vc: rootVC)
        while resultVC?.presentedViewController != nil {
            resultVC = self.topViewController(vc: resultVC?.presentedViewController)
        }
        return resultVC
    }
    
    fileprivate class func topViewController(vc: UIViewController?) -> UIViewController? {
        if let ctrl = vc as? UINavigationController {
            return self.topViewController(vc: ctrl.topViewController)
        } else if let ctrl = vc as? UITabBarController {
            return self.topViewController(vc: ctrl.selectedViewController)
        } else {
            return vc
        }
    }
}
