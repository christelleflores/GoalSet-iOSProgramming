//
//  Goal.swift
//  GoalSet2
//
//  Created by Christelle F on 5/4/22.
//

import CoreData

var goalList = [Goal]()

@objc(Goal)
class Goal: NSManagedObject {
    @NSManaged var id: NSNumber!
    @NSManaged var name: String!
    @NSManaged var date: Date!
    @NSManaged var location: String!
    @NSManaged var deletedDate: Date?
    
    // display the goals for the day selected
    func eventsForDate(date: Date) -> [Goal] {
        var daysGoals = [Goal]()
        for goal in goalList {
            if(Calendar.current.isDate(goal.date, inSameDayAs:date)){
            daysGoals.append(goal)
            }
        }
        return daysGoals
    }
    
}
