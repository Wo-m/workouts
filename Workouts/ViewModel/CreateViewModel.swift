//
//  CreateViewModel.swift
//  Workouts
//
//  Created by Dominic Thompson on 2/10/22.
//

import Foundation
import SwiftUI


@MainActor class CreateViewVM: ObservableObject {
    // Entity Data:
    @Published var sessionName: String = ""
    @Published var exercises: [SessionExercise] = []
    @Published var exerciseName: String = ""
    @Published var reps: String = ""
    @Published var sets: String = ""
    @Published var weight: String = ""
    @Published var timer: String = ""
    @Published var index: Int16 = 0 /// Index of sessionExercise for display order
    
    
    @Published var isAddingExercise: Bool = false
    
    
    // Data Access
    var dataController = DataController()
    
    
    func setIsAddingExercise(bool: Bool) {
        isAddingExercise = bool
    }
    
    func saveSession() {
        dataController.saveSession(UUID(), sessionName, exercises)
    }
    
    func saveExercise() {
        let exercise = dataController.createSessionExerciseWithChildren(timer, weight, reps, sets, exerciseName, index)
        exercises.append(exercise)
        isAddingExercise = false
        index +=  1
        clearExerciseInputs()
    }
    
    func clearExerciseInputs() {
        exerciseName = ""
        reps = ""
        sets = ""
        weight = ""
        timer = ""
    }
    
}

