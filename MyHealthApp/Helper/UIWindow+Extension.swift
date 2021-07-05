//
//  Uiwindow+Extension.swift
//  MyHealthApp
//
//  Created by IDEV on 12/08/20.
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//

import UIKit

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
