//
//  UIVIEW+Extension.swift
//  MyHealthApp
//
//  Created by IDEV on 11/08/20.
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//

import UIKit

//MARK:- Use extension to add shadow to view
extension UIView {
    
    func addShadowToBottom(cornerRadius: CGFloat){
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOpacity = Float(getWidth())
        self.layer.borderColor =  UIColor.clear.cgColor
        self.layer.masksToBounds = false
    }
    
    //MARK:- according to devices or devices width shadowOpacity is given
    func getWidth()->CGFloat{
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return UIScreen.main.bounds.size.width > 375 ? 0.2 : 0.3
        // It's an
        case .pad:
            return 0.3
        case .unspecified:
            return 0.3
        default:
            return 0.3
        }
    }
}
