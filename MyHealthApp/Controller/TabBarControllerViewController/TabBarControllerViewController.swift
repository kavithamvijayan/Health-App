//
//  TabBarControllerViewController.swift
//  MyHealthApp
//
//  Created by IDEV on 12/08/20.
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//

import UIKit

class TabBarControllerViewController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //MARK:- set programatically title with localization
        self.setupTabBar()
    }

    func setupTabBar(){
        guard let items = tabBar.items else { return }
        items[0].title = "fitness".localizableString()
        items[1].title = "Covid Reports".localizableString()
        items[2].title = "Profile".localizableString()
        items[3].title = "Near by gym".localizableString()
    }

}
