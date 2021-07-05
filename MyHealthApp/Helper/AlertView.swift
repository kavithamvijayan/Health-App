//
//  AlertView.swift
//  MyHealthApp
//
//  Created by IDEV on 11/08/20.
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//

import Foundation
import UIKit

/*
* Method name: showAlert
* Description: Used to show UIAlertController
* Parameters: title refers to type String, message refers to type String
* Return:  nil
*/
func showAlert(title: String?, message: String?, buttonTitle: String? = nil) {
    let alert = UIAlertController(title: title,
                                  message: message,
                                  preferredStyle: .alert)
    
    let action = UIAlertAction(title: buttonTitle ?? "OK", style: .cancel, handler: nil)
    alert.addAction(action)
    if let topViewController  = getTopViewController() {
        topViewController.present(alert, animated: true, completion: nil)
    }
}

/*
 * Method name: topMostViewController
 * Description: Used to get the top most visible view controller
 * Parameters: nil
 * Return:  UIViewController
 */
func getTopViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let navigationController = controller as? UINavigationController {
        return getTopViewController(controller: navigationController.visibleViewController)
    }
    if let tabController = controller as? UITabBarController {
        if let selected = tabController.selectedViewController {
            return getTopViewController(controller: selected)
        }
    }
    if let presented = controller?.presentedViewController {
        return getTopViewController(controller: presented)
    }
    return controller
}
