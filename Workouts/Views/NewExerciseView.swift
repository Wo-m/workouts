//
//  newExercise.swift
//  Workouts
//
//  Created by Dominic Thompson on 1/10/22.
//

import Foundation
import SwiftUI

/// Now VM class for this, its very smiple and uses logic from its parents view model: CreateVM
struct NewExerciseView: View {
    @StateObject var viewModel: CreateViewVM
    @Environment(\.colorScheme) var cs
    
    @State var name: String = ""
    @State var reps: String = ""
    @State var sets: String = ""
    @State var weight: String = ""
    @State var timer: String = ""
    
    var body: some View {
        VStack{
            TextField("Exercise Name", text: $name)
                .multilineTextAlignment(.center)
                .font(Font(UIFont.systemFont(ofSize: 30)))
                .padding(.vertical, 30.0)
            
            Spacer()
            
            labelInput(label: "Sets", content: $sets)
            labelInput(label: "Reps", content: $reps)
            labelInput(label: "Weight", content: $weight)
            labelInput(label: "Timer", content: $timer)
            
            HStack {
                Spacer()
                Button("Save") {
                    viewModel.saveExercise(name, sets, reps, weight, timer)
                    viewModel.updateExerciseDisplayInfo()
                }.save()
                Spacer()
                Button("Cancel") {
                    viewModel.setIsAddingExercise(bool: false)
                }.cancel()
                Spacer()
            }
        
        }.background(cs == .dark ? Color.black : Color.white)
        
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
