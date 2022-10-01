//
//  newExercise.swift
//  Workouts
//
//  Created by Dominic Thompson on 1/10/22.
//

import Foundation
import SwiftUI

struct NewExerciseView: View {
    // TODO pass array of Exercixe Model as binding, plus an index
    //      we update the exercise at index
    //      Createview does a for in exercise[]
    @State var exerciseName: String = ""
    @State var reps: String = ""
    @State var sets: String = ""
    @State var weight: String = ""
    @State var timer: String = ""
    @State var index: Int16 = 0
    var dataController = DataController()

    
    // Parameters
    @Binding var isAddingExercise: Bool
    @Binding var exercises: [SessionExercise]
    var sessionId: UUID
    
    var body: some View {
        VStack{
            TextField("Exercise Name", text: $exerciseName)
                .multilineTextAlignment(.center)
                .font(Font(UIFont.systemFont(ofSize: 30)))
                .padding(.vertical, 30.0)
            
            Spacer()
            
            labelInput(label: "Sets", content: $sets)
            labelInput(label: "Reps", content: $reps)
            labelInput(label: "Weight", content: $weight)
            labelInput(label: "Timer", content: $timer)
            
            Button("Save") {
                let exercise = dataController.createSessionExerciseWithChildren(timer, weight, reps, sets, exerciseName, index)
                exercises.append(exercise)
                isAddingExercise = false
                index +=  1
            }
        
        }.background(Color.white)
        
    }
    
}

struct labelInput: View {
    
    var label: String
    @Binding var content: String
    
    
    var body: some View {
        VStack{
            Text(label)
            TextField("0", text: $content)
                .multilineTextAlignment(.center)
                .font(Font(UIFont.systemFont(ofSize: 30)))
            
            Spacer()
        }
    }
}
