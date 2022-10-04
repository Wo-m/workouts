//
//  StartView.swift
//  Workouts
//
//  Created by Dominic Thompson on 1/10/22.
//

import SwiftUI

struct StartView: View {
    @StateObject var viewModel = StartVM()
    @State var sessions: [Session] = []
    let screenSize: CGRect = UIScreen.main.bounds
    let dataController = DataController()
    
    @Environment(\.colorScheme) var cs
    
    var body: some View {
        
        VStack{
            Text("Sessions")
                .heading()
                .padding(.top, 20)
            
            RoundedRectangle(cornerRadius: 25)
                .divider(width: screenSize.width)
            
            Spacer()
            
            ForEach(sessions) { session in
                Button(session.name!) {
                    dataController.delete(object: session)
                }
                .session()
            }
            
            Spacer()
            
        }.onAppear {
            // Update sessions list when view appears
            sessions = getSessions()
        }
    }
    
    func getSessions() -> [Session] {
        let request = Session.fetchRequest()
        return (try? dataController.moc.fetch(request))!
    }
}

