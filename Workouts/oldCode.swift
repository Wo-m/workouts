//
//  oldCode.swift
//  Workouts
//
//  Created by Dominic Thompson on 2/10/22.
//

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


//struct ExerciseTable: View {
//
//    var displayInfo: [DisplayInfo]
//    let screenSize: CGRect = UIScreen.main.bounds
//
//    var body: some View {
//        VStack {
//            RoundedRectangle(cornerRadius: 25)
//                .fill(Color.gray)
//                .frame(width: screenSize.width * 0.85, height: 1,  alignment: .center)
//                .padding([.bottom,], 20)
//                
//            ForEach(displayInfo) { row in
//                // Exercise Name
//                Text(row.name)
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    .padding([.bottom], 5)
//                    .fontWeight(Font.Weight.semibold)
//                
//                // Headers
//                HStack {
//                    Text("Sets").frame(maxWidth: .infinity, alignment: .center)
//                    Text("Reps").frame(maxWidth: .infinity, alignment: .center)
//                    Text("Weight").frame(maxWidth: .infinity, alignment: .center)
//                }.padding([.bottom], 20)
//                // Data
//                HStack {
//                    Text(row.sets).frame(maxWidth: .infinity, alignment: .center)
//                    Text(row.reps).frame(maxWidth: .infinity, alignment: .center)
//                    Text(row.weight).frame(maxWidth: .infinity, alignment: .center)
//                }.padding([.bottom,], 20)
//                
//                // Divider
//                RoundedRectangle(cornerRadius: 25)
//                    .fill(Color.gray)
//                    .frame(width: screenSize.width * 0.85, height: 1,  alignment: .center)
//                    .padding([.bottom,], 20)
//            }
//        }.padding([.bottom], 20)
//    }
//}
