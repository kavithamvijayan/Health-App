//
//  FitnessViewController.swift
//  MyHealthApp
//
//  Created by IDEV on 10/08/20.
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//

import UIKit

class FitnessViewController: UIViewController {
    
    //MARK:-  outlet for Meal Log Button
    @IBOutlet weak var mealLogButton: UIButton!{
        didSet{
            //MARK:- to make button corner round
            self.mealLogButton.layer.cornerRadius = 20.0
        }
    }
    
    //MARK:-  outlet for Daily Water Intake Calculation Log Button
    @IBOutlet weak var dailyWaterIntakeCalButton: UIButton!{
        didSet{
            //MARK:- to make button corner round
            self.dailyWaterIntakeCalButton.layer.cornerRadius = 20.0
        }
    }
    
    //MARK:-  outlet for Ideal Weight CalCulation Button
    @IBOutlet weak var idealWeightCalButton: UIButton!{
        didSet{
            //MARK:- to make button corner round
            self.idealWeightCalButton.layer.cornerRadius = 20.0
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "fitness".localizableString()
        self.setupLocalization()
    }
    
    //MARK:- Button Action for more option
    @IBAction func moreActionButton(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "changeLanguage".localizableString(), style: .default , handler:{ (UIAlertAction)in
            self.pushToChangeLanguage()
            print("User click Approve button")
        }))
        alert.addAction(UIAlertAction(title: "fitness benifit".localizableString(), style: .default , handler:{ (UIAlertAction)in
            self.pushToBenifitFitness()
              }))
        alert.addAction(UIAlertAction(title: "dismiss".localizableString(), style: .cancel, handler:{ (UIAlertAction)in
               print("User click Dismiss button")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // funstion to invoke MealViewController
      func pushToChangeLanguage(){
          let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
          let viewController = storyboard.instantiateViewController(identifier:"ChangeLanguageViewController")
          //MARK:- TO Hide uitabbarcontroller when pushed to MealDetailsViewController
          viewController.hidesBottomBarWhenPushed = true
          // opening the viewcontroller
          self.navigationController?.pushViewController(viewController, animated: true)
      }
    
    //MARK:- SetUp Localization
     func setupLocalization(){
        self.mealLogButton.setTitle("mealLog".localizableString(), for: .normal)
        self.dailyWaterIntakeCalButton.setTitle("dailyWaterIntakeCal".localizableString(), for: .normal)
        self.idealWeightCalButton.setTitle("idealWeightCal".localizableString(), for: .normal)
     }
    
    // funstion to invoke MealViewController
       func pushToBenifitFitness(){
           let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
           let viewController = storyboard.instantiateViewController(identifier:"BenefitFitnessViewController")
           //MARK:- TO Hide uitabbarcontroller when pushed to MealDetailsViewController
           viewController.hidesBottomBarWhenPushed = true
           // opening the viewcontroller
           self.navigationController?.pushViewController(viewController, animated: true)
       }
}
