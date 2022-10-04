//
//  styles.swift
//  Workouts
//
//  Created by Dominic Thompson on 4/10/2022.
//

import Foundation
import SwiftUI


extension TextField {
    func heading() -> some View {
        self.multilineTextAlignment(.center)
            .font(Font(UIFont.systemFont(ofSize: 30)))
            .foregroundColor(.indigo)
            .frame(height: 30)
    }
}

extension Text {
    func heading() -> some View {
        self.multilineTextAlignment(.center)
            .font(Font(UIFont.systemFont(ofSize: 30)))
            .foregroundColor(.indigo)
            .frame(height: 30)
    }
}


extension Button {
    
    func basic(_ cs: ColorScheme) -> some View {
        self.buttonStyle(.bordered)
            .foregroundColor(cs == .dark ? Color.white : Color.black)
            .padding([.top, .bottom], 10)
    }
    
    func session() -> some View {
        self.foregroundColor(Color.white)
            .padding([.top, .bottom], 10)
            .frame(width: 200, height: 50)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.indigo))
            
    }
    
    func save() -> some View {
        self.buttonStyle(.borderedProminent)
            .foregroundColor(Color.white)
            .padding([.top, .bottom], 10)
            .tint(.indigo)
    }
    
    func cancel() -> some View {
        self.buttonStyle(.borderedProminent)
            .foregroundColor(Color.white)
            .padding([.top, .bottom], 10)
            .tint(.red)
    }
}

extension RoundedRectangle {
    func divider(width: CGFloat) -> some View {
        self.fill(Color.indigo)
            .frame(width: width * 0.85, height: 3,  alignment: .center)
            .padding([.top, .bottom,], 20)
    }
}
