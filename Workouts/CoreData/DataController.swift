//
//  DataController.swift
//  Workouts
//
//  Created by Dominic Thompson on 1/10/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Sessions")
    var moc: NSManagedObjectContext {
        return self.container.viewContext
    }
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    
    
    /*
     Call MOC save using controller
     */
    func save() {
        try? moc.save()
    }
    
    /*
     Save a session using id, name, and session exercises
     */
    func saveSession(_ id: UUID, _ name: String, _ exercises: [SessionExercise]) {
        let session = createSession()
        session.id = id
        session.name = name
        session.exercises = NSOrderedSet(array: exercises)
        try? moc.save()
    }
    
    func createSession() -> Session {
        return Session(context: moc)
    }
    
    /*
     Create a session exercise with all child entities
     */
    func createSessionExerciseWithChildren(sets: String, reps: String,  weight: String,
                                           timer: String, name: String, index: Int16)
    -> SessionExercise {
        
        let reference = getReferenceExercise(name)
        
        let instance = createExerciseInstance(sets: sets, reps: reps, weight: weight, timer: timer)
        
        // Generate SessionExercise
        let exercise = SessionExercise(context: moc)
        exercise.referenceExercise = reference
        
        exercise.instances = NSSet(array: [instance])
        exercise.index = index
        
        return exercise
    }
    
    /*
     Create an Exercise instance, along with associate repset entities
     */
    func createExerciseInstance(sets: String, reps: String,  weight: String, timer: String)-> ExerciseInstance {
        
        // TODO: validation (no more than 10 sets, no empty vals, all numbers)
        
        // Generate the Exercise instance
        let instance = ExerciseInstance(context: moc)
        instance.isLatest = true
        instance.timer = Int16(timer)!
        
        // Create repset instances
        var repsets: [Repset] = []
        var i: Int16 = 0
        let numSets: Int = Int(sets)!
        while(i < numSets) {
            let repset = Repset(context: moc)
            repset.set = i
            repset.rep = Int16(reps)!
            repset.weight = Int16(weight)!
            repset.id = UUID()
            
            repsets.append(repset)
            
            i += 1
        }
        
        // Add repset to instance
        instance.repset = NSSet(array: repsets)
        
        return instance
    }
    
    /*
     Get the reference exercise entity based on name,
     if it doesn't exist create it
    */
    func getReferenceExercise(_ name: String) -> ReferenceExercise {
        // Check reference
        let request = ReferenceExercise.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        var result = try? moc.fetch(request)
        
        var reference: ReferenceExercise
        // Create new reference if required
        if (result?.count == 0) {
            reference = ReferenceExercise(context: moc)
            reference.name = name
        } else {
            reference = (result?.removeFirst())!
        }
        return reference
    }
    
    
}
