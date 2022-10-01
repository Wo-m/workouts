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
