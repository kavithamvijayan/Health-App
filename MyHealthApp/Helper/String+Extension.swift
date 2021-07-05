//
//  String+Extension.swift
//  MyHealthApp
//
//  Created by IDEV on 11/08/20.
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//

import Foundation

extension String {
    func localizableString()-> String{
        let langStr = Locale.current.languageCode
        var langKeyWord =  UserDefaults.standard.string(forKey:"selectedLang")
        if langKeyWord == nil {
            if langStr == "es" || langStr == "en" {
                langKeyWord = langStr
            }else{
                langKeyWord = "en"
            }
        }
        let path = Bundle.main.path(forResource: langKeyWord, ofType: "lproj")
        if let bundlePath = path {
            if let bundle = Bundle(path: bundlePath){
                return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
            }
        }
        return ""
    }
    
    public func checkTextCount()->Bool {
        return self.removeWhiteSpacesFromTheString().count == 0 ? false : true
    }
    
    func removeWhiteSpacesFromTheString() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    public func validateEmailAddress()->Bool {
        if self.checkTextCount() {
            return self.isValidEmail()
        }
        return false
    }
    
    private func isValidEmail( ) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }
}
