//
//  ContentView.swift
//  Workouts
//
//  Created by Dominic Thompson on 30/9/22.
//

import SwiftUI

struct MainView: View {
    

    var body: some View {

        TabView{
            CreateView()
                .tabItem {Text("Create")}
            StartView()
                .tabItem {Text("Start")}
            ProgramView()
                .tabItem {Text("Program")}
        }.accentColor(.indigo)

    }
}
