//
//  FitnessTableViewCell.swift
//  MyHealthApp
//
//  Created by IDEV on 11/08/20.
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//

import UIKit

class FitnessTableViewCell: UITableViewCell {
    
    @IBOutlet weak var totalCaloriesValueLabel: UILabel!
    @IBOutlet weak var totalCalories: UILabel!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealTitleLabel: UILabel!
    @IBOutlet weak var holdView: UIView!{
        didSet{
            self.holdView.addShadowToBottom(cornerRadius: 8.0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupLocalization()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Set up localization
    func setupLocalization(){
        self.mealNameLabel.text = "mealName".localizableString()
        self.totalCalories.text = "Total calories".localizableString()
    }
    
    //MARK:- configure cell item
    func configure(mealData: Meal){
        self.mealTitleLabel.text = mealData.mealName
        self.totalCaloriesValueLabel.text = String(format:"%.2f", Double(mealData.totalCalories))
    }
}
