//
//  KeyboardManager.swift
//  MyHealthApp
//
//  Created by Li Yas on 2020-08-11
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//

import Foundation
import UIKit

protocol KeyboardManagerDelegate {
    func whenKeyboardAppears(contentInset:UIEdgeInsets)
    func whenKeyboardHides(contentInset:UIEdgeInsets)
}


class KeyboardManager {
    static let shared = KeyboardManager()
    
    var keyboardDelegate:KeyboardManagerDelegate?
    
    private init() {
        
    }
    
    @objc func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func removeObservers(){
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardAppear(notification:Notification){
        let userinfo = notification.userInfo
        let frame = (userinfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: frame.height + 3, right: 0)
        keyboardDelegate?.whenKeyboardAppears(contentInset: contentInsets)
    }
    
    
    @objc func keyboardDisappear(notification:Notification){
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        keyboardDelegate?.whenKeyboardHides(contentInset: contentInsets)
    }
}
