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
        UIViewController.mg_shaker_top_view_controller()?.present(nav, animated: true, completion: nil)
    }
    
    open override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("Shake cancel")
    }
}

extension UIViewController {
    // Get top view controller
    class func mg_shaker_top_view_controller() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.first
        let rootVC = keyWindow?.rootViewController
        var resultVC = self.mg_shaker_top_view_controller(vc: rootVC)
        while resultVC?.presentedViewController != nil {
            resultVC = self.mg_shaker_top_view_controller(vc: resultVC?.presentedViewController)
        }
        return resultVC
    }
    
    fileprivate class func mg_shaker_top_view_controller(vc: UIViewController?) -> UIViewController? {
        if let ctrl = vc as? UINavigationController {
            return self.mg_shaker_top_view_controller(vc: ctrl.topViewController)
        } else if let ctrl = vc as? UITabBarController {
            return self.mg_shaker_top_view_controller(vc: ctrl.selectedViewController)
        } else {
            return vc
        }
    }
}
