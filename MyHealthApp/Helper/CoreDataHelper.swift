//
//  CoreDataHelper.swift
//  MyHealthApp
//
//  Created by IDEV on 11/08/20.
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//

import Foundation
import CoreData
import UIKit


//MARK:- This class Contain All CRUD Operation in Core Data and this is a singleton class
class CoreDataHelper{
    //MARK:- Create Class Inastance
    static let shared = CoreDataHelper()
    //MARK:- Priviate init because to avoid to create object in another class so, it maintain the singleton rules.
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //MARK:- NSManagedObjectContext handle all CRUD operation
    var context:NSManagedObjectContext!
    
    //MARK:- method for saving Meal Data
    func saveMealData(carb:String,mealName:String,protein:String,fat:String,totalCalories: Double,completion: @escaping (ResponseData<String>) -> Void) {
        //MARK:- context contain CRUD Operation method
        context = appDelegate.persistentContainer.viewContext
        //MARK:- write entity name created in xcdataModel table
        let entity = NSEntityDescription.entity(forEntityName: "Meal", in: context)
        //MARK:- insert new data which user has enter
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(carb, forKey: "carb")
        newUser.setValue(mealName, forKey: "mealName")
        newUser.setValue(protein, forKey: "protein")
        newUser.setValue(fat, forKey: "fat")
        newUser.setValue(totalCalories, forKey: "totalCalories")
        
        do {
            //MARK:- by using this method data will save
            try context.save()
            print("Storing Data..")
            //MARK:- success message will return
            completion(.success(value: "Sucess"))
            
        } catch  {
            print("Storing data Failed")
            //MARK:- failure message will return
            completion(.failure(error: HNError.noData))
        }
    }
    
    
    //MARK:- Fetch all meal data from database
    func fetchMealData()->[NSManagedObject]{
        //MARK:- context contain CRUD Operation method
        context = appDelegate.persistentContainer.viewContext
        
        //MARK:- array for  meal data
        var userDetail = [Meal]()
        
        //MARK:- write entity name for fetching data
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Meal")
        
        do {
            let result = try context.fetch(fetchData)
            userDetail = result as? [Meal] ?? []
        }catch {
            print("err")
        }
        
        return userDetail
    }
    
    //MARK:- Update data to database
    func udateData(mealName:String,carb:String,protein: String,fat: String,totalCalories: Double,index:Int,completion: @escaping (ResponseData<String>) -> Void) {
        //MARK:- context contain CRUD Operation method
        context = appDelegate.persistentContainer.viewContext
        //MARK:- write entity name for fetching data
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Meal")
        do {
            let result = try context.fetch(fetchData)
            if result.count != 0{
                let managedObject = result[index] as? NSManagedObject
                managedObject?.setValue(carb, forKey: "carb")
                managedObject?.setValue(mealName, forKey: "mealName")
                managedObject?.setValue(protein, forKey: "protein")
                managedObject?.setValue(fat, forKey: "fat")
                managedObject?.setValue(totalCalories, forKey: "totalCalories")
                
                do {
                    try context.save()
                    //MARK:- success message will return
                    completion(.success(value: "Sucess"))
                }
                catch {
                    print("error")
                    //MARK:- failure message will return
                    completion(.failure(error: HNError.noData))
                }
            }
        }catch {
            print("err")
            //MARK:- failure message will return
            completion(.failure(error: HNError.noData))
        }
    }
    
    //MARK:- delete data from database
    func deleteMealData(index:Int,completion: @escaping (ResponseData<String>) -> Void) {
        //MARK:- context contain CRUD Operation method
        context = appDelegate.persistentContainer.viewContext
        //MARK:- write entity name for fetching data
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Meal")
        do {
            let result = try context.fetch(fetchData)
            //MARK:- checking condition if is present thend delete the data
            if result.count != 0{
                let managedObject = result[index] as! NSManagedObject
                context.delete(managedObject)
                do {
                    try context.save()
                    //MARK:- success message will return
                    completion(.success(value: "Sucess"))
                }
                catch {
                    print("error")
                    //MARK:- failure message will return
                    completion(.failure(error: HNError.noData))
                }
            }
        }catch {
            print("err")
            //MARK:- failure message will return
            completion(.failure(error: HNError.noData))
        }
        
    }
    
}

