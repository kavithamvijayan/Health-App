//
//  MealDetailsViewController.swift
//  MyHealthApp
//
//  Created by IDEV on 11/08/20.
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//

import UIKit


class MealDetailsViewController: UIViewController {
    
    //outlet for scrollVIew
    @IBOutlet weak var scrollVIew: UIScrollView!
    
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var fatTextField: UITextField!
    
    //outlet for Meal Name title label
    @IBOutlet weak var entermealTitleLabel: UILabel!
    
    //outlet for Meal Name label
    @IBOutlet weak var enterMealNameLabel: UILabel!
    
    //outlet for protein label
    @IBOutlet weak var proteinLAbel: UILabel!
    
    //outlet for carb label
    @IBOutlet weak var carbLabel: UILabel!
    
    //outlet for Meal Name
    @IBOutlet weak var mealNameTextField: UITextField!
    
    //outlet for Protein
    @IBOutlet weak var proteinTextField: UITextField!
    
    //outlet for carb
    @IBOutlet weak var carbTextField: UITextField!
    
    //outlet for save button
    @IBOutlet weak var saveDataButton: UIButton!{
        didSet{
            //to make button corner round
            self.saveDataButton.layer.cornerRadius = 20.0
        }
    }
    
    // save selected particular meal data
    var getMealData: Meal?
    // save particular index path to delete the meal item
    var indexPath: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initial setupView
        self.setupView()
        //localization setup for label
        self.setupLocalization()
    }
    
    //ViewwillAppear
    override func viewWillAppear(_ animated: Bool) {
        KeyboardManager.shared.keyboardDelegate = self
        KeyboardManager.shared.addObservers()
    }
    
    //ViewdidAppear
    override func viewWillDisappear(_ animated: Bool) {
        KeyboardManager.shared.removeObservers()
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        //this is for to save meal data
        self.saveData()
    }
}

extension MealDetailsViewController{
    
    func setupView(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        //when meal data is available then it will show in particular textfield
        self.mealNameTextField.text = getMealData?.mealName ?? ""
        self.proteinTextField.text = getMealData?.protein ?? ""
        self.carbTextField.text = getMealData?.carb ?? ""
        self.fatTextField.text = getMealData?.fat ?? ""
        
        //check condition according it will show a button text
        self.saveDataButton.setTitle(getMealData == nil ? "save".localizableString() : "update".localizableString(), for: .normal)
        
        //TextField Delegate
        self.mealNameTextField.delegate = self
        self.proteinTextField.delegate = self
        self.carbTextField.delegate = self
        self.fatTextField.delegate = self
    }
    
    //Dismiss keyboard
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func setupLocalization(){
        //Localization for label
        self.proteinLAbel.text = "protein".localizableString()
        self.carbLabel.text = "carb".localizableString()
        self.enterMealNameLabel.text = "mealName".localizableString()
        self.entermealTitleLabel.text = "enterMealTitle".localizableString()
        self.fatLabel.text = "Fat".localizableString()
        
        //Localization for textfiels placeholder
        self.mealNameTextField.placeholder = "mealName".localizableString()
        self.proteinTextField.placeholder = "protein".localizableString()
        self.carbTextField.placeholder = "carb".localizableString()
        self.fatTextField.placeholder = "Fat".localizableString()
    }
    
    func saveData(){
        //This condition is to perform save operation or update operation according to condition
        if getMealData == nil {
            //this operation is done for save the meal data
            //OPtional binding is done
            if let cardData = carbTextField.text,let protein = proteinTextField.text,let mealName = mealNameTextField.text,let fat = fatTextField.text {
                
                //Empty textfield condition is check in if condition
                if carbTextField.text != "" && proteinTextField.text != "" && mealNameTextField.text != "" && fatTextField.text != "" {
                    
                    //compilation handler for save Meal data it will return sucess or failer
                    CoreDataHelper.shared.saveMealData(carb: cardData, mealName: mealName, protein: protein, fat: fat, totalCalories: self.calculationForCalories()) { (response) in
                        switch response {
                        case .success(value: _):
                            // adding animation for the viewcontroller popup
                            self.navigationController?.popViewController(animated: true)
                        case .failure(error: let error):
                            print("Error",error.localizedDescription)
                            //Show alert when error occur
                            showAlert(title: "Error", message: error.localizedDescription)
                        }
                    }
                }else{
                    //Show alert when error occur
                    showAlert(title: "Error", message: "Field is Empty")
                }
            }else{
                //Show alert when error occur
                showAlert(title: "Error", message: "Field is Empty")
            }
        }else{
            
            //this operation is done for updating the meal data
            //index path is getting from tableview didselect method to update particular index
            if let indexPath = indexPath {
                
                //compilation handler for update Meal data it will return sucess or failer
                CoreDataHelper.shared.udateData(mealName: mealNameTextField.text ?? "", carb: self.carbTextField.text ?? "", protein:  self.proteinTextField.text ?? "", fat: fatTextField.text ?? "", totalCalories: self.calculationForCalories(), index: indexPath) { (response) in
                    switch response {
                    case .success(value: _):
                        // adding animation for the viewcontroller popup
                        self.navigationController?.popViewController(animated: true)
                    case .failure(error: let error):
                        //Show alert when error occur
                        showAlert(title: "Error", message: error.localizedDescription)
                    }
                }
            }else{
                //Show alert when error occur
                showAlert(title: "Error", message: "Index Error")
            }
        }
    }
    
    //Calories calculation is done and store in local database
    func calculationForCalories()->Double{
        if let proteinValue: Double = Double(self.proteinTextField.text ?? ""),let carbValue: Double = Double(self.carbTextField.text ?? ""),let fatValue: Double = Double(self.fatTextField.text ?? "") {
            let proteinCalCulation: Double = proteinValue * 4
            let carbCalculation: Double = carbValue * 4
            let fatCalculation: Double = fatValue * 9
            
            let tototalCalories: Double = proteinCalCulation + carbCalculation + fatCalculation
            
            return tototalCalories
        }else{
            showAlert(title: "Error", message: "Fetch to fail calories data")
        }
        return 0.0
    }
}

//Keyboard manager delegate
extension MealDetailsViewController: KeyboardManagerDelegate {
    func whenKeyboardAppears(contentInset: UIEdgeInsets) {
        scrollVIew.contentInset = contentInset
    }
    func whenKeyboardHides(contentInset: UIEdgeInsets) {
        scrollVIew.contentInset = contentInset
    }
}

extension MealDetailsViewController: UITextFieldDelegate{

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
