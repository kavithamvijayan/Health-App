//
//  CustomTextField.swift
//  MyHealthApp
//
//  Created by Li Yas on 2020-08-11
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable class CustomTextField: UITextField {
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard() {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        done.tintColor = UIColor.black
        toolbar.setItems([flexSpace,done], animated: false)
        toolbar.sizeToFit()
        self.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}
