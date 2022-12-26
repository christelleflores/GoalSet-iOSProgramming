//
//  EditGoalViewController.swift
//  GoalSet2
//
//  Created by Christelle F on 5/4/22.
//

import UIKit
import CoreData

class EditGoalViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var locationTF: UITextField!
    var selectedGoal: Goal? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (selectedGoal != nil) {
            nameTF.text = selectedGoal?.name
            locationTF.text = selectedGoal?.location
            datePicker.date = (selectedGoal?.date)!
            
        }
        
    }
    
    // saves new goal
    @IBAction func saveAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if(selectedGoal == nil) {
            let entity = NSEntityDescription.entity(forEntityName: "Goal", in: context)
            let newGoal = Goal(entity: entity!, insertInto: context)
            
            newGoal.id = goalList.count as NSNumber
            newGoal.name = nameTF.text
            newGoal.location = locationTF.text
            newGoal.date = datePicker.date
            
            //newGoal.id = fetchedResultsController.fetchedObjects.count as NSNumber?
            //newGoal.setValue(id, forKey: "id")
            //newGoal.setValue(nameTF.text, forKey: "name")
            //newGoal.setValue(locationTF.text, forKey: "location")
            //newGoal.setValue(datePicker.date, forKey: "date")
            
            do {
                try context.save()
                goalList.append(newGoal)
                navigationController?.popViewController(animated: true)
            }
            catch {
                print("save error")
            }
        } else {
            //saves editted goal
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let goal = result as! Goal
                    if(goal == selectedGoal) {
                        goal.name = nameTF.text
                        goal.location = locationTF.text
                        goal.date = datePicker.date
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            } catch {
                 print("fetch failed")
            }
        }
    }
    
    // delete selected goal
    @IBAction func deleteGoal(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results {
                let goal = result as! Goal
                if(goal == selectedGoal) {
                    goal.deletedDate = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        } catch {
             print("fetch failed")
        }
    }
 
}
