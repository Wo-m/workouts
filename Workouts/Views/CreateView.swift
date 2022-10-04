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
    @Environment(\.colorScheme) var cs
    let screenSize: CGRect = UIScreen.main.bounds

    var body: some View {
        VStack{
            TextField("Session Name", text: $viewModel.sessionName)
                .heading()
                .padding(.top, 20)
            
            RoundedRectangle(cornerRadius: 25)
                .divider(width: screenSize.width)


            ScrollView {
                ExerciseTable(displayInfo: viewModel.displayInfo, viewModel: viewModel)
            }
            
            Button("+") {
                viewModel.setIsAddingExercise(bool: true)
            }
            .basic(cs)
            
            Spacer()
            
            Button("Save Session") {
                viewModel.saveSession()
            }.save()
        
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
            ForEach(displayInfo) { row in
                ExerciseTableRow(row: row, viewModel: viewModel)
            }
        }
//        .frame(width: screenSize.width*0.8)
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
                // Applies animation to anything affected by change
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.up.toggle()
                    self.expanded.toggle()
                }
            } label: {
                Image(systemName: "chevron.up")
                    .foregroundColor(.indigo)
                    .rotationEffect(.degrees(self.up ? 0.0 : 180.0))
            }.frame(maxWidth: .infinity, alignment: .center)
            
        }.padding([.bottom,], 20)
        

        ExerciseTableExpansion(viewModel: viewModel, expanded: $expanded, index: row.index)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: expanded ? .none : 0)
            .clipped()
            
        
        // Divider
        RoundedRectangle(cornerRadius: 25)
            .divider(width: screenSize.width)
    }
}

struct ExerciseTableExpansion: View {
    // Params
    @StateObject var viewModel: CreateViewVM
    @Binding var expanded: Bool
    
    let index: Int16
    
    
    
    var body: some View {
        VStack {
            ForEach(viewModel.getRepSets(index: index)) { repset in
                expansionRow(viewModel: viewModel, repset: repset)
                    .isHidden(!expanded)
            }
        }
    }
}

struct expansionRow: View {
    
    // Params
    @StateObject var viewModel: CreateViewVM
    let repset: Repset
    
    // TODO: make this less magic numbery
    let width: CGFloat = UIScreen.main.bounds.width*0.8
    
    
    // State Vars
    @State var rep: String = ""
    @State var weight: String = ""
    
    var body: some View {
        
        /// Bindings to allow updates on change
        // TODO: see if you can set this change on collapse
        let repBinding = Binding<String> (get: {
            self.rep
        }, set: {
            self.rep = $0
            viewModel.updateRepSet(repset: repset, rep: rep)
        })
        
    
        let weightBinding = Binding<String> (get: {
            self.weight
        }, set: {
            self.weight = $0
            viewModel.updateRepSet(repset: repset, weight: weight)
        })
        
        HStack{
            Text(String(repset.set + 1))
                .frame(width: width * 0.2, alignment: .center)
            TextField(String(repset.rep), text: repBinding)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
            TextField( String(repset.weight), text: weightBinding)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

