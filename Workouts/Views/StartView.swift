//
//  StartView.swift
//  Workouts
//
//  Created by Dominic Thompson on 1/10/22.
//

import SwiftUI

struct StartView: View {
    @State var sessions: [Session] = []
    var dataController = DataController()
    
    var body: some View {
        VStack{
            ForEach(sessions) { session in
                Text(session.name ?? "nil")
            }
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

