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
                .padding(.vertical, 15.0)


            
            ExerciseTable(displayInfo: viewModel.displayInfo, viewModel: viewModel)

            
            Button("Add Exercise") {
                viewModel.setIsAddingExercise(bool: true)
            }.buttonStyle(.bordered).foregroundColor(Color.black)
            
            Spacer()
            
            Button("Save") {
                viewModel.saveSession()
            }
        
        }.overlay(alignment: .center) {
            NewExerciseView(viewModel: viewModel).isHidden(!viewModel.isAddingExercise)
        }
    }
    
}


struct ExerciseTable: View {

    var displayInfo: [DisplayInfo]
    let screenSize: CGRect = UIScreen.main.bounds
    
    @StateObject var viewModel: CreateViewVM
    

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.gray)
                .frame(width: screenSize.width * 0.85, height: 1,  alignment: .center)
                .padding([.bottom,], 20)
                
            ForEach(displayInfo) { row in
                ExerciseTableRow(row: row, viewModel: viewModel)
            }
        }
        .frame(width: screenSize.width*0.8)
        .padding([.bottom], 20)
    }
}

struct ExerciseTableRow: View {
    
    // Params
    var row: DisplayInfo
    @StateObject var  viewModel: CreateViewVM
    
    // State Vars
    @State var up: Bool = true
    @State var expanded: Bool = false
    
    // Immutes
    let screenSize: CGRect = UIScreen.main.bounds
    
    
    var body: some View {
        // Exercise Name
        Text(row.name)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding([.bottom], 5)
            .fontWeight(Font.Weight.semibold)
        // Data
        HStack {
            Text(row.sets).frame(maxWidth: .infinity, alignment: .center)
            Text("x").frame(alignment: .center)
            Text(row.reps).frame(maxWidth: .infinity, alignment: .center)
            Text("@").frame(maxWidth: .infinity, alignment: .center)
            Text(row.weight).frame(maxWidth: .infinity, alignment: .center)
            
            Button {
                // Expand
                self.up.toggle()
                self.expanded.toggle()
            } label: {
                Image(systemName: "chevron.up")
                    .rotationEffect(.degrees(self.up ? 0.0 : 180.0))
            }.frame(maxWidth: .infinity, alignment: .center)
            
        }.padding([.bottom,], 20)
        
        
        // Divider
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.gray)
            .frame(width: screenSize.width * 0.85, height: 1,  alignment: .center)
            .padding([.bottom,], 20)
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
