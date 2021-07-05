//
//  CalorieCalculatorController.swift
//  MyHealthApp
//
//  Created by Li Yas on 2020-07-24.
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//


import UIKit

// controller to add meals
// implementing table view

class CalorieCalculatorController: UIViewController {
    
    //MARK:- outlet for table View
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    //MARK:-  array to save meal entries
    var mealData = [Meal]()
    
    //MARK:- TAbleview cell name for register in tableview
    let kFitnessTableViewCell = "FitnessTableViewCell"
    
    @IBAction func AddButtonClicked(_ sender: Any) {
        self.insertCalorieEntry()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setting tableview delegate and datasource with self
        tableView.delegate = self
        tableView.dataSource = self
        //MARK:- initial setup method
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "meals".localizableString()
        //MARK:- Fetching save data from database
        self.fetchMealData()
    }
    
}

// extended funstions of tableView
extension CalorieCalculatorController: UITableViewDelegate,UITableViewDataSource{
    // function to return meals count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mealData .count
    }
    // funstion that adds the text to row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let myCell = tableView.dequeueReusableCell(withIdentifier: kFitnessTableViewCell, for: indexPath) as? FitnessTableViewCell {
            myCell.configure(mealData: mealData[indexPath.row])
            return myCell
        }
        return UITableViewCell()
    }
    
    // enabling the table view edit feature
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //MARK:- deleting the values in Table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete)
        {
            //MARK:- compilation handler for delete Meal data it will return sucess or failer
            CoreDataHelper.shared.deleteMealData(index: indexPath.row) { (response) in
                switch response {
                case .success(value: _):
                    //MARK:-  removing frpom the array
                    self.mealData.remove(at: indexPath.row)
                    //MARK:- tableview updates
                    self.tableView.reloadData()
                case .failure(error: let error):
                    print("error",error.localizedDescription)
                    //MARK:- show alert when error occur
                    showAlert(title: "Error", message: error.localizedDescription)
                }
            }
            
        }
    }
    
    //MARK:- Ridrect the tableview from one controller to another
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier:"mealController") as! MealDetailsViewController
        //MARK:- TO Hide uitabbarcontroller when pushed to MealDetailsViewController
        viewController.hidesBottomBarWhenPushed = true
        //MARK:- update meal array
        viewController.getMealData = mealData[indexPath.row]
        //MARK:- update indexpath to delete the meal item
        viewController.indexPath = indexPath.row
        // opening the viewcontroller
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension CalorieCalculatorController {
    
    //MARK:- Initial setup view function is called in viewDidLoad
    func setupView(){
        //MARK:- tableview cell is register
        self.tableView.register(UINib(nibName: kFitnessTableViewCell, bundle: nil), forCellReuseIdentifier: kFitnessTableViewCell)
        //MARK:- setUp localization for UIBarButtonItem title
        self.addButton.title = "add".localizableString()
    }
    
    //MARK:- fetch data from local database method
    func fetchMealData() {
        //MARK:- fetch the data from local database
        self.mealData = CoreDataHelper.shared.fetchMealData() as? [Meal] ?? []
        //MARK:- TableView reload after fetching the data
        self.tableView.reloadData()
    }
    
    // funstion to invoke MealViewController
    func insertCalorieEntry(){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier:"mealController")
        //MARK:- TO Hide uitabbarcontroller when pushed to MealDetailsViewController
        viewController.hidesBottomBarWhenPushed = true
        // opening the viewcontroller
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
