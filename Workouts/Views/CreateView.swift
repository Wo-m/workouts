//
//  CreateView.swift
//  Workouts
//
//  Created by Dominic Thompson on 1/10/22.
//

import SwiftUI
import CoreData



struct CreateView: View {
    @StateObject var viewModel = CreateViewVM()

    var body: some View {
        VStack{
            TextField("Session Name", text: $viewModel.sessionName)
                .multilineTextAlignment(.center)
                .font(Font(UIFont.systemFont(ofSize: 30)))
                .padding(.vertical, 30.0)

            Spacer()
            
            ForEach(viewModel.exercises) { exercise in
                exerciseRow(exercise: exercise)
            }
            
            Spacer()
            
            Button("+") {
                viewModel.setIsAddingExercise(bool: true)
            }
            
            Button("Save") {
                viewModel.saveSession()
            }
        
        }.overlay(alignment: .center) {
            NewExerciseView(viewModel: viewModel).isHidden(!viewModel.isAddingExercise)
        }

        
    }
}


//struct exerciseRow: View {
//
//    var exercise: SessionExercise
//    var instance: ExerciseInstance
//
//    init(exercise: SessionExercise) {
//
//    }
//
//    var body: some View {
//        HStack {
//            Text(exercise.referenceExercise?.name ?? "nil")
////            Text(String(getSets()))
////            Text(String(getReps()))
//        }
//    }
//
////    func getSets() -> Int {
////        return exercise.instances.
////    }
////
////    func getReps() -> Int {
////        let arr = exercise.repset?.sortedArray(using: [NSSortDescriptor(key: "rep", ascending: true)]) as? [Repset]
////        return Int(arr?[0].rep ?? 0)
////    }
////
////    func getWeight() -> Int {
////        let arr = exercise.repset?.sortedArray(using: [NSSortDescriptor(key: "weight", ascending: true)])
////        return arr?.last as! Int
////    }
////
//}
