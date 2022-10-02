//
//  CreateModels.swift
//  Workouts
//
//  Created by Dominic Thompson on 2/10/22.
//

import Foundation

struct DisplayInfo: Identifiable {
    let name: String
    let sets: String
    let reps: String
    let weight: String
    let index: Int16
    let id = UUID()
}
