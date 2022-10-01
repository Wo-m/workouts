//
//  WorkoutsTests.swift
//  WorkoutsTests
//
//  Created by Dominic Thompson on 1/10/22.
//

import XCTest

@testable import Workouts

class WorkoutsTests: XCTestCase {
    var dataController: DataController = DataController()

    
    func testCreateWorkoutInstance() {
        let time = "90"
        let weight = "50"
        let reps = "5"
        let sets = "5"
        
        let w1 = dataController.createExerciseInstance(time, weight, reps, sets)
        let w2 = dataController.createExerciseInstance(time, weight, reps, sets)
        
        assert(w1.timer == Int16(time))
        assert(w2.timer == Int16(time))
    }
    
    func testCreateSession() {
        let time = "90"
        let weight = "50"
        let reps = "5"
        let sets = "5"
        
        let name1 = "Squats"
        let name2 = "Lunges"
        
        let w1 = dataController.createSessionExerciseWithChildren(time, weight, reps, sets, name1, 0)
        let w2 = dataController.createSessionExerciseWithChildren(time, weight, reps, sets, name2, 1)
        
        let exercises = [w1, w2]
        
        let id = UUID()
        let sessionName = "legs"
        
        
        dataController.saveSession(id, sessionName, exercises)
        
        // Check reference
        let request = Session.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        let result = try? dataController.moc.fetch(request)
        
        let session = result?[0]
        assert(session?.name == sessionName)
        assert(session?.exercises?.count == 2)
    }

}
