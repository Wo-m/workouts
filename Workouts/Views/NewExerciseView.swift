//
//  newExercise.swift
//  Workouts
//
//  Created by Dominic Thompson on 1/10/22.
//

import Foundation
import SwiftUI

struct NewExerciseView: View {
    @StateObject var viewModel: CreateViewVM
    
    var body: some View {
        VStack{
            TextField("Exercise Name", text: $viewModel.exerciseName)
                .multilineTextAlignment(.center)
                .font(Font(UIFont.systemFont(ofSize: 30)))
                .padding(.vertical, 30.0)
            
            Spacer()
            
            labelInput(label: "Sets", content: $viewModel.sets)
            labelInput(label: "Reps", content: $viewModel.reps)
            labelInput(label: "Weight", content: $viewModel.weight)
            labelInput(label: "Timer", content: $viewModel.timer)
            
            Button("Save") {
                viewModel.saveExercise()
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
