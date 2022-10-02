//
//  CreateViewModel.swift
//  Workouts
//
//  Created by Dominic Thompson on 2/10/22.
//

import Foundation
import SwiftUI


class CreateViewVM: ObservableObject {
    // Entity Data:
    @Published var sessionName: String = ""
    @Published var exercises: [SessionExercise] = []
    @Published var index: Int16 = 0 /// Index of sessionExercise for display order
    @Published var displayInfo: [DisplayInfo] = []
    
    
    @Published var isAddingExercise: Bool = false
    
    
    // Data Access
    var dataController = DataController()
    
    
    func setIsAddingExercise(bool: Bool) {
        isAddingExercise = bool
    }
    
    func saveSession() {
        dataController.saveSession(UUID(), sessionName, exercises)
    }
    
    func saveExercise(_ name: String, _ sets: String, _ reps: String, _ weight: String, _ timer: String) {
        let exercise = dataController.createSessionExerciseWithChildren(timer, weight, reps, sets, name, index)
        exercises.append(exercise)
        isAddingExercise = false
        index +=  1 // Added exercise so increase index
    }

    /// Takes all exercises in current CreateView, and returns data to be displayed on screen
    func updateExerciseDisplayInfo() {
        var out: [DisplayInfo] = []
        for exercise in exercises {
            let instance = (exercise.instances?.allObjects as! [ExerciseInstance])[0]
            
            let name = exercise.referenceExercise?.name ?? "nil"
            let sets = getSets(instance: instance)
            let reps = getReps(instance: instance)
            let weight = getWeight(instance: instance)
            let index = exercise.index
            
            let displayInfo = DisplayInfo(name: name, sets: sets, reps: reps, weight: weight, index: index)
            out.append(displayInfo)
        }
        displayInfo = out
    }
    
    func getSets(instance: ExerciseInstance) -> String {
        let repsets: [Repset] = instance.repset?.allObjects as! [Repset]
        return String(repsets.count)
    }
    
    /// For now returns the max reps
    func getReps(instance: ExerciseInstance) -> String {
        var repsets: [Repset] = instance.repset?.allObjects as! [Repset]
        repsets = repsets.sorted {
            return $0.rep > $1.rep
        }
        return String(repsets[0].rep)
    }
    
    func getWeight(instance: ExerciseInstance) -> String {
        var repsets: [Repset] = instance.repset?.allObjects as! [Repset]
        repsets = repsets.sorted {
            return $0.weight > $1.weight
        }
        return String(repsets[0].weight)+"kg"
    }
}

