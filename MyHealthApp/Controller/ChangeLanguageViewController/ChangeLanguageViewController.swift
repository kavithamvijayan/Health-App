//
//  ChangeLanguageViewController.swift
//  MyHealthApp
//
//  Created by IDEV on 11/08/20.
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//

import UIKit

class ChangeLanguageViewController: UIViewController {

    @IBOutlet weak var changeLanguageTitleLabel: UILabel!
    @IBOutlet weak var selectSpanishButton: UIButton!
    @IBOutlet weak var selectEnglishButton: UIButton!
    @IBOutlet weak var selectLanguageButton: UIButton!{
        didSet{
            self.selectLanguageButton.layer.cornerRadius = 20.0
        }
    }
    
    let uncheckImage = UIImage(named: "Uncheck")
    let checkImage = UIImage(named: "check")
    var selectedLang: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "changeLanguage".localizableString()
        self.setupView()
    }
    
    @IBAction func languageButton(_ sender: UIButton) {
        if sender.tag == 0{
            self.checkSelectedLanguageKeyword(kLang: "en")
            self.selectedLang = "en"
        }else{
            self.checkSelectedLanguageKeyword(kLang: "es")
            self.selectedLang = "es"
        }
    }
    
    @IBAction func selectLanguageActionButton(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "selectedLang")
        UserDefaults.standard.set(self.selectedLang, forKey: "selectedLang")
        UserDefaults.standard.synchronize()
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let viewController = storyboard.instantiateViewController(identifier:"TabBarController")
        if let keyWindow = UIWindow.key {
            keyWindow.rootViewController = viewController
        }
    }
   
}

extension ChangeLanguageViewController{
    func setupView(){
        let langStr = Locale.current.languageCode
        var langKeyWord = UserDefaults.standard.string(forKey: "selectedLang")
        if langKeyWord == nil {
            if langStr == "es" || langStr == "en" {
                langKeyWord = langStr
            }else{
                langKeyWord = "en"
            }
        }
        self.selectedLang = langKeyWord
        if langKeyWord == "en" {
            self.checkSelectedLanguageKeyword(kLang: "en")
        }else{
            self.checkSelectedLanguageKeyword(kLang: "es")
        }
        self.changeLanguageTitleLabel.text = "selectLanguage".localizableString()
        self.selectLanguageButton.setTitle("save".localizableString(), for: .normal)
    }
    
    func checkSelectedLanguageKeyword(kLang: String){
        switch kLang {
        case "es":
            self.selectEnglishButton.setImage(uncheckImage, for: .normal)
            self.selectSpanishButton.setImage(checkImage, for: .normal)
        default:
            self.selectEnglishButton.setImage(checkImage, for: .normal)
            self.selectSpanishButton.setImage(uncheckImage, for: .normal)
        }
    }
    
    func pushTabbaerVC(){
        
    }
}

