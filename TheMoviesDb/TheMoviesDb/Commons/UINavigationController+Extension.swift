//
//  UINavigationController+Extension.swift
//  TheMoviesDb
//
//  Created by admin on 4/17/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    @objc public class func currentActiveNavigationController() -> UINavigationController? {
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        if let navi = keyWindow?.rootViewController?.presentedViewController as? UINavigationController {
            return navi
        }
        let windows = UIApplication.shared.windows;
        var ortherNavi: UINavigationController?
        
        for oneWindow in windows {
            if let tab = oneWindow.rootViewController as? UITabBarController {
                return tab.selectedViewController as? UINavigationController
            }
            if let navi = oneWindow.rootViewController as? UINavigationController {
                ortherNavi =  navi
            }
        }
        return ortherNavi
    }
    
}
