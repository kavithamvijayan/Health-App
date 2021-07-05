//
//  WaterIntakeViewController.swift
//  MyHealthApp
//
//  Created by Li Yas on 2020-07-24.
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//


import UIKit

class WaterIntakeViewController: UIViewController {
    
    //enum for errorhandling
    enum MyErrorEnum : Error {
        case InvalidNumberError
        case NothingError
    }
    
    //outlet for text field Body weight
    
    @IBOutlet weak var bodyWeightTextField: UITextField!
    //outlet for text field minutes of exercise
    
    @IBOutlet weak var exerciseTextField: UITextField!
    //outlet for result label
    @IBOutlet weak var resultLabel: UILabel!
    
    // outlet for  calaculate Button
    @IBOutlet weak var calaculateButton: UIButton!{
        didSet{
            //to make button corner round
            self.calaculateButton.layer.cornerRadius = 20.0
        }
    }
    
    
    var activeTextField = UITextField()
    
    
    
    // calculate button action
    @IBAction func calculateClickAction(_ sender: Any) {
        //invoking the function
        do {
            let result = try calculateWaterIntake()
            print(result)
        } catch MyErrorEnum.NothingError {
            resultLabel.text = ("inputfieldscan'tBeEmpty".localizableString())
        }
        catch MyErrorEnum.InvalidNumberError {
            resultLabel.text = ("Invalid input".localizableString())
        } catch {
            resultLabel.text = ("all exceptions".localizableString())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setup localization to button and textfield placeholder
        self.setupLocalization()
        self.setupView()
        self.setupMenuItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "waterIntakecalculator".localizableString()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Action that invokes when taps on the screen. To hide the keyboard
    @IBAction func dismissKeyBoardOnTap(_ sender: Any) {
        bodyWeightTextField.resignFirstResponder()
        exerciseTextField.resignFirstResponder()
    }
    
    // Function to calculate the water intake
    
    func calculateWaterIntake() throws->NSData? {
        if(bodyWeightTextField.text == "" || exerciseTextField.text == "")
        {
            throw MyErrorEnum.NothingError
        } else {
            // getting values from text fields
            guard let bodyWeight: Double =
                Double(bodyWeightTextField.text ?? "") else{ throw MyErrorEnum.InvalidNumberError }
            guard let minutesExercise: Double = Double(exerciseTextField.text ?? "") else{ throw MyErrorEnum.InvalidNumberError }
            
                // initializing variable result as 0
                if(minutesExercise < 0 || bodyWeight < 0){
                    throw MyErrorEnum.NothingError
                } else {
                    var result : Double = 0
                    // calculating water intake
                    result = bodyWeight * (2/3)
                    result += (minutesExercise/30)*12
                    //setting label with string
                    resultLabel.text = "Drink".localizableString() + "\(String(format:"%.2f", result))" + " ounces per day.".localizableString()
                    return NSData(bytes:&result, length: MemoryLayout<Double>.size)
                }
            
        }
    }
}


extension WaterIntakeViewController {
    
    func setupLocalization(){
        self.calaculateButton.setTitle("calculate".localizableString(), for: .normal)
        self.bodyWeightTextField.placeholder = "bodyWeight(in lbs)".localizableString()
        self.exerciseTextField.placeholder = "minutesOfExerciseDaily".localizableString()
    }
    
    func setupView(){
        self.bodyWeightTextField.delegate = self
        self.exerciseTextField.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Dismiss keyboard
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func setupMenuItem(){
        let defaultVal = UIMenuItem(title: "Default Value", action: #selector(defaultValueMethod))
        UIMenuController.shared.menuItems = [defaultVal]
    }
    @objc func defaultValueMethod(){
        if self.activeTextField == self.bodyWeightTextField {
            self.bodyWeightTextField.text = "60"
        }else{
            self.exerciseTextField.text = "10"
        }
    }
}

extension WaterIntakeViewController: UITextFieldDelegate {
    
    // Assign the newly active text field to your activeTextField variable
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    
}
