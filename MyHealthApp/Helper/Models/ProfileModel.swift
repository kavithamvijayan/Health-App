//
//  ProfileModel.swift
//  MyHealthApp
//
//  Created by Li Yas on 2020-08-11
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//

import Foundation

class ProfileModel                   : NSObject, NSCoding { 
    private var name                 : String?
    private var email                : String?
    private var gender               : String?
    private var dateOfBirth          : String?
    private var profileImage         : Data?
    
    init(name: String, email: String, gender: String, dateOfBirth: String, profileImage: Data?) {
        self.name = name
        self.email = email
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.profileImage = profileImage
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(email, forKey: "email")
        coder.encode(gender, forKey: "gender")
        coder.encode(dateOfBirth, forKey: "dateOfBirth")
        coder.encode(profileImage, forKey: "profileImage")
    }
    
    required convenience init?(coder: NSCoder) {
        guard
            let name = coder.decodeObject(forKey: "name") as? String,
            let email = coder.decodeObject(forKey: "email") as? String,
            let gender = coder.decodeObject(forKey: "gender") as? String,
            let dateOfBirth = coder.decodeObject(forKey: "dateOfBirth") as? String,
            let profileImage = coder.decodeObject(forKey: "profileImage") as? Data
            else {
                return nil
        }
        self.init(name : name, email : email, gender : gender, dateOfBirth : dateOfBirth, profileImage: profileImage)
    }
    
    var getName: String {
        return name ?? ""
    }
    
    var getEmail: String {
        return email ?? ""
    }
    
    var getDob: String {
        return dateOfBirth ?? ""
    }
    
    var getGender: String {
        return gender ?? ""
    }
    
    var getProfileImage: Data? {
        return profileImage
    }
}
