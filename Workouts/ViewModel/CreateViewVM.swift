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
        if !sessionName.isEmpty {
            dataController.saveSession(UUID(), sessionName, exercises)
        } // TODO: Make it clear session name is empty
    }
    func saveExercise(_ name: String, _ sets: String, _ reps: String, _ weight: String, _ timer: String) {
        let exercise = dataController.createSessionExerciseWithChildren(sets: sets, reps: reps,
                                                                        weight: weight, timer: timer, name: name, index: index)
        exercises.append(exercise)
        isAddingExercise = false
        index +=  1 // Added exercise so increase index
    }

    
    //
    func getRepSets(index: Int16) -> [Repset] {
        return getRepSets(instance: getExerciseInstanceForIndex(index: index)!)
    }
    
    
    // Returns optional, nil if no exercise for index
    func getExerciseInstanceForIndex(index: Int16) -> ExerciseInstance? {
        
        for exercise in exercises {
            if (exercise.index == index){
                return (exercise.instances?.allObjects as! [ExerciseInstance])[0]
            }
        }
        
        return nil
    }
    
    // Ordered by set num
    func getRepSets(instance: ExerciseInstance) -> [Repset] {
        return instance.repset?.sortedArray(using: [NSSortDescriptor(key: "set", ascending: true)]) as! [Repset]
    }
    
    func updateRepSet(repset: Repset, rep: String) {
        if rep.isInt16 { // Check string
            repset.rep = rep.int16
        }
    }
    
    func updateRepSet(repset: Repset,  weight: String) {
        if weight.isFloat {
            repset.weight = weight.float
        }
    }
    
    
    // Takes all exercises in current CreateView, and returns data to be displayed on screen
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

