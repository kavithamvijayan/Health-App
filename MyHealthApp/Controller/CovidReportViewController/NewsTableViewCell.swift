//
//  NewsTableViewCell.swift
//  MyHealthApp
//
//  Created by IDEV on 12/08/20.
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryTitle: UILabel!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var confirmedTitle: UILabel!
    @IBOutlet weak var confirmedCount: UILabel!
    @IBOutlet weak var recoveredTitle: UILabel!
    @IBOutlet weak var recoveredCount: UILabel!
    @IBOutlet weak var deathTitle: UILabel!
    @IBOutlet weak var deathCount: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK:- Set the UI labels
    func setUpView() {
        countryTitle.text = "country".localizableString()
        confirmedTitle.text = "confirmed".localizableString()
        recoveredTitle.text = "recovered".localizableString()
        deathTitle.text = "deaths".localizableString()
    }
    
    // MARK:- Map the api response to the labels
    func configureCell(countryDetail: Countries) {
        countryName.text = countryDetail.getCountry
        confirmedCount.text =  "\(countryDetail.getConfirmed ?? 0)"
        recoveredCount.text = "\(countryDetail.getRecovered ?? 0)"
        deathCount.text = "\(countryDetail.getDeaths ?? 0)"
    }
    
}
