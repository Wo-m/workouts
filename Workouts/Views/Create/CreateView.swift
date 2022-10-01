//
//  CreateView.swift
//  Workouts
//
//  Created by Dominic Thompson on 1/10/22.
//

import SwiftUI
import CoreData



struct CreateView: View {
    @State var sessionName: String = ""
    @State var isAddingExercise: Bool = false
    @State var exercises: [SessionExercise] = []
    var dataController = DataController()
    
    // Session to be saved
    @State var id = UUID()
    
    var body: some View {
        VStack{
            TextField("Session Name", text: $sessionName)
                .multilineTextAlignment(.center)
                .font(Font(UIFont.systemFont(ofSize: 30)))
                .padding(.vertical, 30.0)

            Spacer()
            
            ForEach(exercises) { exercise in
                exerciseRow(exercise: exercise)
            }
            
            Spacer()
            
            Button("+") {
                isAddingExercise = true
            }
            
            Button("Save") {
                id = UUID()
                dataController.saveSession(id, sessionName, exercises)
            }

        }.overlay(alignment: .center) {
            NewExerciseView(isAddingExercise: $isAddingExercise, exercises: $exercises, sessionId: id).isHidden(!isAddingExercise)
        }

        
    }
}


struct exerciseRow: View {
    
    var exercise: SessionExercise
    
    var body: some View {
        HStack {
            Text(exercise.referenceExercise?.name ?? "nil")
//            Text(String(getSets()))
//            Text(String(getReps()))
        }
    }
    
//    func getSets() -> Int {
//        return exercise.instance.repset?.count ?? 0
//    }
//
//    func getReps() -> Int {
//        let arr = exercise.repset?.sortedArray(using: [NSSortDescriptor(key: "rep", ascending: true)]) as? [Repset]
//        return Int(arr?[0].rep ?? 0)
//    }
//
//    func getWeight() -> Int {
//        let arr = exercise.repset?.sortedArray(using: [NSSortDescriptor(key: "weight", ascending: true)])
//        return arr?.last as! Int
//    }
    
    
}

//struct CreateView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateView(moc: moc)
//    }
//}


//VStack{
//            Button("Add") {
//                let name = "squats"
//
//                let exercise = Exercise(context: moc)
//                exercise.id = UUID()
//                exercise.name = name
//                exercise.timer = 30
//
//                try? moc.save()
//                moc.reset()
//                // more code to come
//            }
//
//            Button("Clear") {
//                for exercise in exercises {
//                    moc.delete(exercise)
//                }
//            }
//
//            VStack {
//                List(exercises) { exercise in
//                    Text(exercise.name ?? "Unknown")
//                }
//            }
//        }
