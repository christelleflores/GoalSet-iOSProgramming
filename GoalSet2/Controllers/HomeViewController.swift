//
//  HomeViewController.swift
//  GoalSet2
//
//  Created by Christelle F on 5/3/22.
//

import UIKit
import CoreData

var selectedDate = Date()
//var goalList = [Goal]()


class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,
                            UITableViewDelegate, UITableViewDataSource {
    
    var firstLoad = true
    var selectedGoal: Goal? = nil
    
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    

    var totalSquares = [Date]()
    
    //swipe right gesture
    @IBAction func swipeRight(_ sender: Any) {
        print("swipe right gesture")
        navigationController?.popViewController(animated: true)
    }
    
    //deletes goals from table view
    func nonDeletedGoals() -> [Goal] {
        var noDeletedGoalsList = [Goal]()
        for goal in goalList {
            if(goal.deletedDate == nil) {
                noDeletedGoalsList.append(goal)
            }
        }
        
        return noDeletedGoalsList
    }
    
    /*
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    lazy var fetchedResultsController: NSFetchedResultsController<Goal> = {
            print("fetch")
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
            fetchRequest.sortDescriptors = [NSSortDescriptor (key: "name", ascending: true)]
            
            let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
            
            fetchedResultsController.delegate = self
            return fetchedResultsController
            
    }()
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //when view loads display list of goals in table view
        if (firstLoad) {
            firstLoad = false
            print("work")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let goal = result as! Goal
                    goalList.append(goal)
                }
            } catch {
                 print("fetch failed")
            }
        }
        
        setCellsView()
        setWeekView()
        
    }
    
    //creates calendar view
    func setCellsView() {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2)
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    //displays weeks
    func setWeekView() {
        totalSquares.removeAll()
        
        var current = CalendarHelper().sundayForDate(date: selectedDate)
        let nextSunday = CalendarHelper().addDays(date: current, days: 7)
        
        while (current < nextSunday) {
            totalSquares.append(current)
            current = CalendarHelper().addDays(date: current, days: 1)
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
            + " " + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
        tableView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    // display day
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calID", for: indexPath) as! CalendarCell
        
        let date = totalSquares[indexPath.item]
        cell.dayOfMonth.text = String(CalendarHelper().dayOfMonth(date: date))
        
        if(date == selectedDate) {
            cell.backgroundColor = UIColor.lightGray
        }
        else {
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalSquares[indexPath.item]
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    //show last week
    @IBAction func previousWeek(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: -7)
        setWeekView()
    }
    //show next week
    @IBAction func nextWeek(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 7)
        setWeekView()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    
    //update tableview according to what was deleted
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return goalList.count
        return nonDeletedGoals().count
        //return Goal().eventsForDate(date: selectedDate).count
         
    }
    
    //selects cell form tableview to be edited or deleted
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "calID", for: indexPath) as! GoalCell
        let currCell: Goal!
        let goal = Goal().eventsForDate(date: selectedDate)[indexPath.row]
        currCell = nonDeletedGoals()[indexPath.row]
        cell.goalName.text = currCell.name + " @" + CalendarHelper().timeString(date: goal.date)
        cell.goalLocation.text = currCell.location
        
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editGoal", sender: self)
    }
    
    //segue from the cell to edit instead of creating a new goal
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editGoal") {
            let indexPath = tableView.indexPathForSelectedRow!
            let goalDetail = segue.destination as? EditGoalViewController
            
            let selectedGoal: Goal!
            selectedGoal = nonDeletedGoals()[indexPath.row]
            goalDetail!.selectedGoal = selectedGoal
            
            tableView.deselectRow(at: indexPath, animated: true)
            
        }
    }
}
