//
//  NewsHeaderView.swift
//  MyHealthApp
//
//  Created by IDEV on 12/08/20.
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//

import UIKit

class NewsHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var globalTitle: UILabel!
    @IBOutlet weak var confirmedTitle: UILabel!
    @IBOutlet weak var confirmedCount: UILabel!
    @IBOutlet weak var recoveredTitle: UILabel!
    @IBOutlet weak var recoveredCount: UILabel!
    @IBOutlet weak var deathTitle: UILabel!
    @IBOutlet weak var deathCount: UILabel!
    
    override func awakeFromNib() {
        
    }
    
    // MARK:- Set the UI labels
    func setUpView() {
        globalTitle.text = "globalCount".localizableString()
        confirmedTitle.text = "confirmed".localizableString()
        recoveredTitle.text = "recovered".localizableString()
        deathTitle.text = "deaths".localizableString()
    }
    
    // MARK:- Map the api response to the labels
    func configureCell(globalDetail: Global) {
        confirmedCount.text =  "\(globalDetail.getConfirmed ?? 0)"
        recoveredCount.text = "\(globalDetail.getRecovered ?? 0)"
        deathCount.text = "\(globalDetail.getDeaths ?? 0)"
    }
    
}
