//
//  UINavigationController+Ext.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/9/14.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import ReSwiftRouter

// Extension that provides completion blocks for push/pop on navigation controllers.
// Thanks to: http://stackoverflow.com/questions/9906966/completion-handler-for-uinavigationcontroller-pushviewcontrolleranimated
extension UINavigationController {
    
    func pushViewController(_ viewController: UIViewController,
                            animated: Bool, completion: @escaping () -> Void) {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    func popViewController(_ animated: Bool, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: animated)
        CATransaction.commit()
    }
}


extension UIViewController{
    public static func route() -> RouteElementIdentifier{
        return String(describing: self)
    }
}